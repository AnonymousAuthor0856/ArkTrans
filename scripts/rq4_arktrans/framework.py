#!/usr/bin/env python3
"""
ArkTransFramework - Base skill class encapsulating the 4-step pipeline + REAL compile + repair loop.
This is the 'skill' that an Agent can call as a tool.
"""

import os
import sys
import json
import time
import tempfile
import shutil
import subprocess
import re
from pathlib import Path
from typing import Dict, List, Any, Optional, Tuple
from dataclasses import dataclass, field
from datetime import datetime

sys.path.insert(0, os.path.join(os.path.dirname(__file__), 'kt2ets'))
sys.path.insert(0, os.path.join(os.path.dirname(__file__), 'swift2ets'))

from dotenv import load_dotenv
_script_dir = Path(__file__).parent
load_dotenv(_script_dir.parent / '.env')
load_dotenv()

# Real compiler paths
HVIGORW = os.environ.get("HVIGORW", "hvigorw")
JAVA_HOME = os.environ.get("JAVA_HOME", "")
TEMPLATE = Path(os.environ.get("MINIMAL_HOS_TEMPLATE",
                  str(Path(__file__).resolve().parents[1] / "evaluate" / "minimal_hos")))

@dataclass
class TranslationResult:
    file_id: str
    source_path: str
    source_lang: str
    output_dir: str
    json_data: Optional[Dict] = None
    skeleton_code: Optional[str] = None
    llm_raw_code: Optional[str] = None
    postfixed_code: Optional[str] = None
    iteration_codes: List[str] = field(default_factory=list)
    iteration_errors: List[str] = field(default_factory=list)
    final_code: Optional[str] = None
    compiles: bool = False
    compile_errors: List[str] = field(default_factory=list)
    token_usage: Dict[str, int] = field(default_factory=dict)
    latency_ms: float = 0.0
    num_iterations: int = 0
    created_at: str = field(default_factory=lambda: datetime.now().isoformat())
    
    def to_dict(self) -> Dict:
        return {
            'file_id': self.file_id, 'source_lang': self.source_lang,
            'compiles': self.compiles, 'num_iterations': self.num_iterations,
            'token_usage': self.token_usage, 'latency_ms': self.latency_ms,
            'final_code_length': len(self.final_code) if self.final_code else 0,
            'created_at': self.created_at,
        }

class ArkTransFramework:
    """Skill: 4-step pipeline + real compile + repair loop."""
    
    def __init__(self, provider: str = "deepseek", temperature: float = 0.0, max_iterations: int = 5):
        self.provider = provider
        self.temperature = temperature
        self.max_iterations = max_iterations
        self.results: List[TranslationResult] = []
        self._pipeline_module = None
        self._kt_parser = None
        self._kt_generator = None
        self._swift_parser = None
        self._swift_generator = None
    
    def _get_pipeline(self):
        if self._pipeline_module is None:
            import pipeline as pl
            self._pipeline_module = pl
        return self._pipeline_module
    
    def _get_model_config(self):
        pl = self._get_pipeline()
        try:
            return pl.get_model_config(self.provider)
        except ValueError:
            env_prefix = self.provider.upper().replace('-', '_')
            fallbacks = {"deepseek": "deepseek-chat", "gpt": "gpt-4o-mini", "claude": "claude-3-5-sonnet-20241022"}
            return {
                "model": os.getenv(f"{env_prefix}_MODEL", fallbacks.get(self.provider.lower(), "")),
                "api_key": os.getenv(f"{env_prefix}_API_KEY", ""),
                "base_url": os.getenv(f"{env_prefix}_BASE_URL", ""),
            }
    
    # Step 1: Parse
    def step1_parse(self, source_path: str) -> Optional[Dict]:
        source_path = Path(source_path)
        from tree_kt import KotlinUIParser
        if self._kt_parser is None:
            self._kt_parser = KotlinUIParser()
        with open(source_path, 'r', encoding='utf-8') as f:
            return self._kt_parser.parse(f.read())
    
    # Step 2: Skeleton
    def step2_skeleton(self, ui_data: Dict) -> str:
        from generator import ArkTSGeneratorV3
        if self._kt_generator is None:
            mapping_path = os.path.join(os.path.dirname(__file__), '..', 'kt2ets', 'mappings', 'components.json')
            self._kt_generator = ArkTSGeneratorV3(mapping_path)
        return self._kt_generator.generate(ui_data)
    
    # Step 1: Parse Swift
    def step1_parse_swift(self, source_path: str) -> Optional[Dict]:
        source_path = Path(source_path)
        from tree_swift import SwiftUIExtractor
        if self._swift_parser is None:
            self._swift_parser = SwiftUIExtractor()
        return self._swift_parser.analyze(str(source_path))
    
    # Step 2: Skeleton Swift
    def step2_skeleton_swift(self, ui_data: Dict) -> str:
        from generator_swift import SwiftArkTSGenerator
        if self._swift_generator is None:
            mapping_path = os.path.join(os.path.dirname(__file__), '..', 'swift2ets', 'mappings', 'components.json')
            self._swift_generator = SwiftArkTSGenerator(mapping_path)
        return self._swift_generator.generate(ui_data)
    
    # Step 3: LLM
    def step3_translate(self, ui_data: Dict, skeleton_code: str) -> Tuple[str, Dict]:
        pl = self._get_pipeline()
        model_config = self._get_model_config()
        code = pl.call_llm(ui_data, skeleton_code, model_config, self.provider)
        usage = {
            'prompt_tokens': len(skeleton_code) // 4,
            'completion_tokens': len(code) // 4,
            'total_tokens': (len(skeleton_code) + len(code)) // 4,
        }
        return code, usage
    
    # Step 4: Postfix
    def step4_postfix(self, code: str) -> str:
        pl = self._get_pipeline()
        return pl.post_fix(code)
    
    # Compile check (REAL hvigor)
    def compile_check(self, ets_file: str) -> Tuple[bool, List[str]]:
        try:
            with tempfile.TemporaryDirectory() as tmpdir:
                project = Path(tmpdir) / "test"
                shutil.copytree(TEMPLATE, project, dirs_exist_ok=True,
                              ignore=shutil.ignore_patterns('.idea', '.git', 'build', '.hvigor'))
                shutil.copy(ets_file, project / "entry" / "src" / "main" / "ets" / "pages" / "Index.ets")
                sdk_dir = os.environ.get("HOS_SDK_DIR", "")
                if sdk_dir:
                    (project / "local.properties").write_text(
                        f"arkui-x.dir={sdk_dir}\nsdk.dir={sdk_dir}\n", encoding="utf-8")
                
                env = os.environ.copy()
                env["JAVA_HOME"] = JAVA_HOME
                env["PATH"] = f"{JAVA_HOME}/bin:{Path(HVIGORW).parent}:{env.get('PATH', '')}"
                
                # --no-daemon: hvigor daemons never exit and each holds hundreds of
                # system file-table entries; ~50 daemons exhaust kern.maxfiles (65536)
                result = subprocess.run([HVIGORW, "--no-daemon", "assembleHap"], cwd=str(project),
                                        capture_output=True, text=True, timeout=180, env=env)
                
                output = result.stdout + result.stderr
                output = re.sub(r'\x1b\[[0-9;]*m', '', output)
                output = re.sub(r'\[\d+m', '', output)
                
                if result.returncode == 0:
                    return True, []
                
                errors = []
                blocks = re.findall(
                    r'\d+\s*ERROR:\s*(\d+)\s*ArkTS\s*Compiler\s*Error\s*\n'
                    r'Error\s*Message:\s*(.+?)At\s*File:\s*[^:]+:(\d+):(\d+)',
                    output, re.DOTALL
                )
                for code, msg, line, col in blocks:
                    clean = ' '.join(msg.split())
                    errors.append(f"[{code}] Line {line}: {clean}")
                
                return False, errors
        except Exception as e:
            return False, [str(e)]
    
    # LLM Raw call (for repair)
    def call_llm_raw(self, system_prompt: str, user_prompt: str) -> Tuple[str, Dict]:
        code, usage, _raw = self.call_llm_verbose(system_prompt, user_prompt)
        return code, usage

    # LLM call that also returns the raw model response (before markdown stripping)
    def call_llm_verbose(self, system_prompt: str, user_prompt: str) -> Tuple[str, Dict, str]:
        model_config = self._get_model_config()
        pl = self._get_pipeline()

        from openai import OpenAI
        client = OpenAI(api_key=model_config["api_key"], base_url=model_config["base_url"] or None)
        kwargs = {
            "model": model_config["model"],
            "messages": [{"role": "system", "content": system_prompt}, {"role": "user", "content": user_prompt}],
            "temperature": self.temperature,
        }
        if self.provider.lower() == "qwen":
            # Thinking mode can burn the whole output budget and return empty content
            kwargs["max_tokens"] = 16384
            kwargs["extra_body"] = {"enable_thinking": False}
        response = client.chat.completions.create(**kwargs)
        raw = response.choices[0].message.content or ""
        code = pl.extract_code(raw)
        usage = {
            'prompt_tokens': response.usage.prompt_tokens if response.usage else 0,
            'completion_tokens': response.usage.completion_tokens if response.usage else 0,
            'total_tokens': response.usage.total_tokens if response.usage else 0,
        }
        return code, usage, raw
    
    # Repair code based on errors
    def repair(self, code: str, errors: List[str]) -> Optional[str]:
        if not errors:
            return code
        
        system = """You are an expert ArkTS developer. Fix compilation errors.
Rules:
1. ONLY fix reported errors, don't change working code
2. Return COMPLETE corrected file
3. All @Component properties must have default values
4. Only use @State on main @Entry component
5. Use interface for type declarations"""
        
        user = f"Errors:\n{chr(10).join(errors[:15])}\n\nCode:\n```typescript\n{code}\n```\n\nFix ALL errors. Return complete corrected code."
        
        try:
            return self.call_llm_raw(system, user)[0]
        except Exception as e:
            print(f"    [Repair] Failed: {e}")
            return None
    
    # Full pipeline + compile + repair
    def run_with_compile(self, source_path: str, output_dir: str) -> TranslationResult:
        start_time = time.time()
        source_path = Path(source_path)
        file_id = source_path.stem
        
        result = TranslationResult(
            file_id=file_id, source_path=str(source_path),
            source_lang='kotlin', output_dir=output_dir
        )
        
        # Step 1: Parse
        print(f"  [Skill] Step 1: Parsing...")
        result.json_data = self.step1_parse(str(source_path))
        if result.json_data is None:
            return result
        print(f"    Parsed: {len(result.json_data.get('ui_structure', []))} components")
        
        # Step 2: Skeleton
        print(f"  [Skill] Step 2: Generating skeleton...")
        result.skeleton_code = self.step2_skeleton(result.json_data)
        print(f"    Generated: {len(result.skeleton_code)} chars")
        
        # Step 3: LLM
        print(f"  [Skill] Step 3: LLM translation ({self.provider})...")
        result.llm_raw_code, usage = self.step3_translate(result.json_data, result.skeleton_code)
        result.token_usage = usage
        print(f"    Generated: {len(result.llm_raw_code)} chars")
        
        # Step 4: Postfix
        print(f"  [Skill] Step 4: Post-fixing...")
        result.postfixed_code = self.step4_postfix(result.llm_raw_code)
        result.final_code = result.postfixed_code
        print(f"    Post-fixed: {len(result.postfixed_code)} chars")
        
        # Save output
        out_path = Path(output_dir)
        out_path.mkdir(parents=True, exist_ok=True)
        output_file = out_path / "Index.ets"
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(result.final_code)
        
        # Step 5: Real compile
        print(f"  [Skill] Step 5: Real compile check...")
        ok, errors = self.compile_check(str(output_file))
        result.compiles = ok
        result.compile_errors = errors
        
        if ok:
            print(f"    ✅ COMPILES (0 errors)")
            result.latency_ms = (time.time() - start_time) * 1000
            return result
        
        print(f"    ❌ FAILED ({len(errors)} errors)")
        
        # Step 6: Repair loop
        for iteration in range(1, self.max_iterations + 1):
            print(f"  [Skill] Step 6: Repair iteration {iteration}/{self.max_iterations}...")
            
            fixed = self.repair(result.final_code, errors)
            if fixed is None:
                break
            
            result.iteration_codes.append(fixed)
            result.final_code = fixed
            result.num_iterations = iteration
            
            with open(output_file, 'w', encoding='utf-8') as f:
                f.write(fixed)
            
            ok, errors = self.compile_check(str(output_file))
            result.compiles = ok
            result.compile_errors = errors
            
            if ok:
                print(f"    ✅ REPAIRED and COMPILES")
                break
            else:
                print(f"    ❌ Still {len(errors)} errors")
        
        result.latency_ms = (time.time() - start_time) * 1000
        self.results.append(result)
        return result
    
    # Full pipeline for Swift
    def run_with_compile_swift(self, source_path: str, output_dir: str) -> TranslationResult:
        start_time = time.time()
        source_path = Path(source_path)
        file_id = source_path.stem
        
        result = TranslationResult(
            file_id=file_id, source_path=str(source_path),
            source_lang='swift', output_dir=output_dir
        )
        
        # Step 1: Parse
        print(f"  [Skill] Step 1: Parsing Swift...")
        result.json_data = self.step1_parse_swift(str(source_path))
        if result.json_data is None or 'error' in result.json_data:
            print(f"    Parse failed: {result.json_data}")
            return result
        print(f"    Parsed: {len(result.json_data.get('ui_structure', []))} components")
        
        # Step 2: Skeleton
        print(f"  [Skill] Step 2: Generating skeleton...")
        result.skeleton_code = self.step2_skeleton_swift(result.json_data)
        print(f"    Generated: {len(result.skeleton_code)} chars")
        
        # Step 3: LLM
        print(f"  [Skill] Step 3: LLM translation ({self.provider})...")
        result.llm_raw_code, usage = self.step3_translate(result.json_data, result.skeleton_code)
        result.token_usage = usage
        print(f"    Generated: {len(result.llm_raw_code)} chars")
        
        # Step 4: Postfix
        print(f"  [Skill] Step 4: Post-fixing...")
        result.postfixed_code = self.step4_postfix(result.llm_raw_code)
        result.final_code = result.postfixed_code
        print(f"    Post-fixed: {len(result.postfixed_code)} chars")
        
        # Save output
        out_path = Path(output_dir)
        out_path.mkdir(parents=True, exist_ok=True)
        output_file = out_path / "Index.ets"
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(result.final_code)
        
        # Step 5: Real compile
        print(f"  [Skill] Step 5: Real compile check...")
        ok, errors = self.compile_check(str(output_file))
        result.compiles = ok
        result.compile_errors = errors
        
        if ok:
            print(f"    ✅ COMPILES (0 errors)")
            result.latency_ms = (time.time() - start_time) * 1000
            return result
        
        print(f"    ❌ FAILED ({len(errors)} errors)")
        
        # Step 6: Repair loop
        for iteration in range(1, self.max_iterations + 1):
            print(f"  [Skill] Step 6: Repair iteration {iteration}/{self.max_iterations}...")
            
            fixed = self.repair(result.final_code, errors)
            if fixed is None:
                break
            
            result.iteration_codes.append(fixed)
            result.final_code = fixed
            result.num_iterations = iteration
            
            with open(output_file, 'w', encoding='utf-8') as f:
                f.write(fixed)
            
            ok, errors = self.compile_check(str(output_file))
            result.compiles = ok
            result.compile_errors = errors
            
            if ok:
                print(f"    ✅ REPAIRED and COMPILES")
                break
            else:
                print(f"    ❌ Still {len(errors)} errors")
        
        result.latency_ms = (time.time() - start_time) * 1000
        self.results.append(result)
        return result

# CLI Entry Point (for Agent to call as a tool)
def main():
    import argparse
    parser = argparse.ArgumentParser(description="ArkTrans Skill - CLI")
    sub = parser.add_subparsers(dest="cmd")
    
    p = sub.add_parser("translate", help="Full pipeline + compile + repair")
    p.add_argument("source_file", help="Input Kotlin or Swift file")
    p.add_argument("-o", "--output", required=True, help="Output directory")
    p.add_argument("--provider", default="deepseek")
    p.add_argument("--max-repair", type=int, default=5)
    p.add_argument("--lang", choices=["kotlin", "swift"], default="kotlin", help="Source language")
    
    p2 = sub.add_parser("compile", help="Real compile check")
    p2.add_argument("ets_file", help="ArkTS file to compile")
    
    args = parser.parse_args()
    
    if args.cmd == "translate":
        skill = ArkTransFramework(provider=args.provider, max_iterations=args.max_repair)
        if args.lang == "swift":
            result = skill.run_with_compile_swift(args.source_file, args.output)
        else:
            result = skill.run_with_compile(args.source_file, args.output)
        print(json.dumps({
            "success": result.compiles,
            "compiles": result.compiles,
            "iterations": result.num_iterations,
            "errors": result.compile_errors,
            "error_count": len(result.compile_errors),
            "output_file": str(Path(args.output) / "Index.ets"),
            "latency_ms": result.latency_ms,
            "tokens": result.token_usage,
        }, indent=2))
        sys.exit(0 if result.compiles else 1)
    
    elif args.cmd == "compile":
        skill = ArkTransFramework()
        ok, errors = skill.compile_check(args.ets_file)
        print(json.dumps({"compiles": ok, "errors": errors, "error_count": len(errors)}, indent=2))
        sys.exit(0 if ok else 1)
    
    else:
        parser.print_help()
        sys.exit(1)

if __name__ == "__main__":
    main()

#!/usr/bin/env python3
"""
ArkTransAgent - Agent that inherits ArkTransFramework and adds compiler-feedback iterative repair.

This directly addresses reviewer concerns about:
1. Weak baselines (agent-based migration vs direct prompting)
2. Missing compiler-feedback loops
3. Need for stronger evaluation comparisons
"""

import os
import sys
import re
import json
import subprocess
from pathlib import Path
from typing import Dict, List, Any, Optional, Tuple
from dataclasses import dataclass, field
from datetime import datetime

from framework import ArkTransFramework, TranslationResult
from compiler_interface import RealCompilerInterface

class ArkTransAgent(ArkTransFramework):
    """
    Agent that extends ArkTransFramework with:
    1. Compiler feedback iterative repair
    2. Multiple LLM model support
    3. Cost and efficiency tracking
    4. Deterministic vs non-deterministic evaluation
    """
    
    def __init__(self, 
                 provider: str = "gpt",
                 model_config: Optional[Dict] = None,
                 temperature: float = 0.0,
                 max_iterations: int = 5,
                 enable_compiler_feedback: bool = True,
                 enable_skill_guidance: bool = True):
        super().__init__(provider, temperature, max_iterations)
        
        self.enable_compiler_feedback = enable_compiler_feedback
        self.enable_skill_guidance = enable_skill_guidance
        self.compiler = RealCompilerInterface()
        
        # Statistics
        self.total_api_calls = 0
        self.total_tokens_used = 0
        self.total_repair_iterations = 0
        self.successful_repairs = 0
        
    def run_with_feedback(self, source_path: str, output_dir: str) -> TranslationResult:
        """
        Run the full pipeline with compiler feedback loop.
        
        Algorithm:
        1. Run base 4-step pipeline
        2. Check compilation
        3. If errors, feed errors back to LLM for repair
        4. Repeat up to max_iterations
        """
        import time
        start_time = time.time()
        
        source_path = Path(source_path)
        file_id = source_path.stem
        source_lang = 'kotlin' if source_path.suffix == '.kt' else 'swift'
        
        result = TranslationResult(
            file_id=file_id,
            source_path=str(source_path),
            source_lang=source_lang,
            output_dir=output_dir
        )
        
        # Phase 1: Run base skill pipeline
        print(f"\n{'='*60}")
        print(f"[Agent] Processing {file_id} with {self.provider}")
        print(f"{'='*60}")
        
        print(f"\n[Phase 1] Base Skill Pipeline")
        if source_lang == 'swift':
            result.json_data = self.step1_parse_swift(str(source_path))
        else:
            result.json_data = self.step1_parse(str(source_path))
        if result.json_data is None:
            print(f"    Failed at parsing")
            return result
        
        if source_lang == 'swift':
            result.skeleton_code = self.step2_skeleton_swift(result.json_data)
        else:
            result.skeleton_code = self.step2_skeleton(result.json_data)
        result.llm_raw_code, usage = self.step3_translate(result.json_data, result.skeleton_code)
        result.token_usage = usage
        self.total_tokens_used += usage.get('total_tokens', 0)
        self.total_api_calls += 1
        
        result.postfixed_code = self.step4_postfix(result.llm_raw_code)
        current_code = result.postfixed_code
        result.iteration_codes.append(current_code)
        
        # Phase 2: Compiler feedback loop
        if self.enable_compiler_feedback:
            print(f"\n[Phase 2] Compiler Feedback Loop (max {self.max_iterations} iterations)")
            
            for iteration in range(self.max_iterations):
                is_compilable, errors = self.compiler.check(current_code)
                result.compile_errors = errors
                
                if is_compilable:
                    print(f"    ✓ Compilation successful after {iteration} repair iterations")
                    result.compiles = True
                    result.num_iterations = iteration
                    break
                
                print(f"    Iteration {iteration + 1}: {len(errors)} error(s) found")
                for err in errors[:3]:  # Show first 3 errors
                    print(f"      - {err}")
                
                # Repair: feed errors back to LLM
                repaired_code, repair_usage = self._repair_code(
                    current_code, errors, result.skeleton_code, result.json_data
                )
                result.token_usage['repair_tokens'] = result.token_usage.get('repair_tokens', 0) + repair_usage.get('total_tokens', 0)
                self.total_tokens_used += repair_usage.get('total_tokens', 0)
                self.total_api_calls += 1
                self.total_repair_iterations += 1
                
                current_code = self.step4_postfix(repaired_code)
                result.iteration_codes.append(current_code)
                result.iteration_errors.append('\n'.join(errors))
            else:
                # Max iterations reached without success
                print(f"    ✗ Max iterations reached, compilation still failing")
                result.compiles = False
                result.num_iterations = self.max_iterations
        else:
            # No compiler feedback, just check once
            is_compilable, errors = self.compiler.check(current_code)
            result.compiles = is_compilable
            result.compile_errors = errors
        
        result.final_code = current_code
        result.latency_ms = (time.time() - start_time) * 1000
        
        # Save output
        self._save_result(result, output_dir)
        
        self.results.append(result)
        return result
    
    def _repair_code(self, current_code: str, errors: List[str], 
                     skeleton_code: str, ui_data: Dict) -> Tuple[str, Dict]:
        """
        Ask LLM to repair the code based on compiler errors.
        """
        error_text = '\n'.join([f"{i+1}. {err}" for i, err in enumerate(errors)])
        
        system_prompt = """You are an expert ArkTS developer. Fix the provided code so it compiles.

CRITICAL ArkTS rules (violations cause compilation failure):
1. ALL properties in @Component struct MUST have initial values: `label: string = ""` NOT `label: string`
2. @Component structs CANNOT have constructor parameters; use @ObjectLink/@Prop/@State for parent->child data
3. NEVER use `new` keyword in ArkTS
4. NEVER use `console.log`; use `console.info` if needed
5. State variables MUST use @State decorator AND `this.` prefix when accessed
6. List children MUST be wrapped in ListItem(), Grid children in GridItem()
7. Use ONLY these components: Stack, Column, Row, Grid, List, Text, Button, Image, Progress, Slider, Blank, Divider, TextInput
8. Output compilable ArkTS code only, no explanations"""
        
        user_prompt = f"""Fix the following ArkTS code which has compilation errors:

**Compiler Errors:**
{error_text}

**Current Code:**
```typescript
{current_code}
```

**Original Skeleton (for reference):**
```typescript
{skeleton_code}
```

Please output the fixed, compilable ArkTS code only:"""
        
        code, usage = self.call_llm_raw(system_prompt, user_prompt)
        return code, usage
    
    def _save_result(self, result: TranslationResult, output_dir: str):
        """Save the final result to disk."""
        output_path = Path(output_dir) / self.provider / f"{result.file_id}.ets"
        output_path.parent.mkdir(parents=True, exist_ok=True)
        
        with open(output_path, 'w', encoding='utf-8') as f:
            f.write(result.final_code or "")
        
        # Save metadata
        meta_path = Path(output_dir) / self.provider / f"{result.file_id}.json"
        with open(meta_path, 'w', encoding='utf-8') as f:
            json.dump(result.to_dict(), f, indent=2, ensure_ascii=False)
        
        print(f"    Saved: {output_path}")
    
    def run_batch(self, source_dir: str, output_dir: str, 
                  file_pattern: str = "*.kt") -> List[TranslationResult]:
        """Run agent on all matching files in a directory."""
        source_dir = Path(source_dir)
        files = sorted(source_dir.glob(file_pattern))
        
        print(f"\n{'='*60}")
        print(f"[Agent Batch] {len(files)} files, provider={self.provider}")
        print(f"{'='*60}")
        
        results = []
        for i, f in enumerate(files, 1):
            print(f"\n[{i}/{len(files)}] {f.name}")
            result = self.run_with_feedback(str(f), output_dir)
            results.append(result)
        
        # Print summary
        self._print_batch_summary(results)
        return results
    
    def _print_batch_summary(self, results: List[TranslationResult]):
        """Print summary statistics for a batch run."""
        total = len(results)
        compiled = sum(1 for r in results if r.compiles)
        avg_iterations = sum(r.num_iterations for r in results) / total if total else 0
        avg_latency = sum(r.latency_ms for r in results) / total if total else 0
        total_tokens = sum(
            r.token_usage.get('total_tokens', 0) + r.token_usage.get('repair_tokens', 0)
            for r in results
        )
        
        print(f"\n{'='*60}")
        print(f"[Batch Summary] Provider: {self.provider}")
        print(f"{'='*60}")
        print(f"  Total files:      {total}")
        print(f"  Compiled:         {compiled} ({compiled/total*100:.1f}%)")
        print(f"  Failed:           {total - compiled}")
        print(f"  Avg iterations:   {avg_iterations:.1f}")
        print(f"  Avg latency:      {avg_latency:.0f}ms")
        print(f"  Total tokens:     {total_tokens}")
        print(f"  Total API calls:  {self.total_api_calls}")
        print(f"{'='*60}")
    
    def get_statistics(self) -> Dict:
        """Get agent statistics."""
        return {
            'provider': self.provider,
            'total_api_calls': self.total_api_calls,
            'total_tokens_used': self.total_tokens_used,
            'total_repair_iterations': self.total_repair_iterations,
            'successful_repairs': self.successful_repairs,
            'num_files_processed': len(self.results),
        }

def main():
    import argparse
    
    parser = argparse.ArgumentParser(
        description="ArkTrans Agent - Compiler-feedback iterative migration"
    )
    parser.add_argument("input", help="Input file or directory")
    parser.add_argument("-o", "--output", required=True, help="Output directory")
    parser.add_argument("-p", "--provider", default="gpt",
                       choices=["gpt", "gpt-4o", "deepseek", "kimi-turbo", 
                               "claude", "codex", "opencode", "mini-swe", "glm", "qwen"],
                       help="LLM provider")
    parser.add_argument("--max-iterations", type=int, default=5,
                       help="Max compiler feedback iterations (default: 5)")
    parser.add_argument("--no-compiler-feedback", action="store_true",
                       help="Disable compiler feedback loop (base skill only)")
    parser.add_argument("--temperature", type=float, default=0.0,
                       help="LLM temperature")
    
    args = parser.parse_args()
    
    agent = ArkTransAgent(
        provider=args.provider,
        temperature=args.temperature,
        max_iterations=args.max_iterations,
        enable_compiler_feedback=not args.no_compiler_feedback
    )
    
    input_path = Path(args.input)
    if input_path.is_file():
        result = agent.run_with_feedback(str(input_path), args.output)
        print(f"\nResult: {'Compiled' if result.compiles else 'Failed'} "
              f"(iterations={result.num_iterations})")
    else:
        # Directory mode
        pattern = "*.kt" if any(f.suffix == '.kt' for f in input_path.iterdir()) else "*.swift"
        agent.run_batch(str(input_path), args.output, pattern)

if __name__ == "__main__":
    main()

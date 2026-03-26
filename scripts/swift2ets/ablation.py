#!/usr/bin/env python3
"""Ablation Study Module - Test different input combinations"""

import argparse
import json
import os
import sys
from pathlib import Path
from typing import Optional

# Import from existing modules
from pipeline_swift import (
    load_dotenv, MODEL_CONFIGS, get_model_config, 
    is_valid_file, extract_code
)

# Load environment variables
load_dotenv()


def load_json(json_path: str) -> dict:
    """Load JSON file"""
    with open(json_path, 'r', encoding='utf-8') as f:
        return json.load(f)


def llm_call(system_prompt: str, user_prompt: str, model_config: dict) -> str:
    """Generic LLM call for ablation study"""
    import os
    
    provider = model_config.get("provider", "")
    
    # GLM uses ZhipuAI client
    if provider == "glm":
        from zhipuai import ZhipuAI
        client = ZhipuAI(api_key=model_config["api_key"])
        
        response = client.chat.completions.create(
            model=model_config["model"],
            messages=[
                {"role": "system", "content": system_prompt},
                {"role": "user", "content": user_prompt}
            ],
            thinking={"type": "disabled"},
            temperature=float(os.getenv("TEMPERATURE", "0.0"))
        )
        return extract_code(response.choices[0].message.content)
    
    # OpenAI-compatible clients (GPT, DeepSeek, Kimi, Claude)
    from openai import OpenAI
    client = OpenAI(
        api_key=model_config["api_key"], 
        base_url=model_config["base_url"]
    )
    
    temperature = float(os.getenv("TEMPERATURE", "0.0"))
    
    response = client.chat.completions.create(
        model=model_config["model"],
        messages=[
            {"role": "system", "content": system_prompt},
            {"role": "user", "content": user_prompt}
        ],
        temperature=temperature
    )
    return extract_code(response.choices[0].message.content)


def load_base_code(base_code_path: str) -> str:
    """Load base code file"""
    with open(base_code_path, 'r', encoding='utf-8') as f:
        return f.read()


def get_ui_description(json_path: str) -> str:
    """Extract UI description from JSON"""
    data = load_json(json_path)
    ui_structure = data.get("ui_structure", [])
    state_vars = data.get("state_variables", {})
    
    lines = ["UI Structure:"]
    
    comp_count = {}
    def count_components(nodes):
        for node in nodes:
            comp = node.get("component", "Unknown")
            comp_count[comp] = comp_count.get(comp, 0) + 1
            count_components(node.get("children", []))
    
    count_components(ui_structure)
    for comp, count in sorted(comp_count.items()):
        lines.append(f"  - {comp}: {count}")
    
    if state_vars:
        lines.append("\nState Variables:")
        for name, info in state_vars.items():
            init_val = info.get("initial_value", "")
            if len(str(init_val)) > 30:
                init_val = str(init_val)[:30] + "..."
            lines.append(f"  - {name}: {info.get('type', 'any')} = {init_val}")
    
    return "\n".join(lines)


# ============ Ablation Prompts ============

# ===== A1 Prompt =====
A1_SYSTEM_PROMPT = """You are an expert in converting SwiftUI JSON to ArkTS (HarmonyOS).
Convert the given complete SwiftUI JSON representation to compilable ArkTS code.
Output ONLY the code without explanations."""

# ===== A2 Prompt =====
A2_SYSTEM_PROMPT = """You are an expert ArkTS developer.
Convert this ArkTS-style SwiftUI Compose IR to compilable ArkTS code.
Output ONLY the code without explanations."""

A2_USER_PROMPT_TEMPLATE = """Convert this base ArkTS code to compilable ArkTS code:

```typescript
{base_code}
```

Output compilable ArkTS code only."""


def build_ablation_a1_prompt(json_path: str) -> tuple:
    """A1: JSON only"""
    import json
    ui_data = load_json(json_path)
    
    json_str = json.dumps(ui_data, indent=2, ensure_ascii=False)
    
    user_prompt = f"""Convert this SwiftUI JSON to ArkTS:

```json
{json_str}
```

Output compilable ArkTS code only."""
    
    return A1_SYSTEM_PROMPT, user_prompt


def build_ablation_a2_prompt(json_path: str, base_code_path: str) -> tuple:
    """A2: Base-code only"""
    base_code = load_base_code(base_code_path)
    
    user_prompt = A2_USER_PROMPT_TEMPLATE.format(base_code=base_code)
    
    return A2_SYSTEM_PROMPT, user_prompt


# ============ Ablation Runners ============

def run_ablation_a1(json_path: str, output_base: str, provider: str, skip_existing: bool = True) -> Optional[str]:
    """Run A1 ablation: JSON only"""
    basename = Path(json_path).stem
    output_dir = Path(output_base) / "ablation" / provider / "a1-json-only"
    output_path = output_dir / f"{basename}.ets"
    
    if skip_existing and is_valid_file(output_path):
        print(f"    Skip: {output_path} exists")
        return load_base_code(str(output_path))
    
    print(f"  A1: JSON only → {output_path}")
    
    system_prompt, user_prompt = build_ablation_a1_prompt(json_path)
    
    model_config = get_model_config(provider)
    model_config["provider"] = provider
    code = llm_call(system_prompt, user_prompt, model_config)
    
    if not code or len(code.strip()) < 50:
        print(f"    ✗ Failed: Empty output")
        return None
    
    output_dir.mkdir(parents=True, exist_ok=True)
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(code)
    print(f"    Saved: {output_path}")
    
    return code


def run_ablation_a2(json_path: str, base_code_path: str, output_base: str, provider: str, skip_existing: bool = True) -> Optional[str]:
    """Run A2 ablation: JSON + base-code"""
    basename = Path(json_path).stem
    output_dir = Path(output_base) / "ablation" / provider / "a2-json-basecode"
    output_path = output_dir / f"{basename}.ets"
    
    if skip_existing and is_valid_file(output_path):
        print(f"    Skip: {output_path} exists")
        return load_base_code(str(output_path))
    
    print(f"  A2: JSON + base-code → {output_path}")
    
    system_prompt, user_prompt = build_ablation_a2_prompt(json_path, base_code_path)
    
    model_config = get_model_config(provider)
    model_config["provider"] = provider
    code = llm_call(system_prompt, user_prompt, model_config)
    
    if not code or len(code.strip()) < 50:
        print(f"    ✗ Failed: Empty output")
        return None
    
    output_dir.mkdir(parents=True, exist_ok=True)
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(code)
    print(f"    Saved: {output_path}")
    
    return code


def print_prompts(json_path: str, base_code_path: str = None):
    """Print prompts for inspection"""
    print("=" * 80)
    print("ABLATION A1 PROMPT (JSON Only)")
    print("=" * 80)
    
    sys_prompt, user_prompt = build_ablation_a1_prompt(json_path)
    print(f"\n[System Prompt]\n{sys_prompt}")
    print(f"\n[User Prompt]\n{user_prompt[:1000]}...")
    
    if base_code_path and Path(base_code_path).exists():
        print("\n" + "=" * 80)
        print("ABLATION A2 PROMPT (Base-code Only)")
        print("=" * 80)
        
        sys_prompt, user_prompt = build_ablation_a2_prompt(json_path, base_code_path)
        print(f"\n[System Prompt]\n{sys_prompt}")
        print(f"\n[User Prompt]\n{user_prompt[:1000]}...")


def main():
    parser = argparse.ArgumentParser(
        description="Ablation Study - Test different input combinations",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Run all ablations for one file
  python3 ablation.py outputs/json/001.json -o outputs -p gpt
  
  # Run all ablations for multiple files
  python3 ablation.py outputs/json/001.json outputs/json/002.json -o outputs -p deepseek
  
  # Run specific ablation only
  python3 ablation.py outputs/json/001.json -o outputs -p gpt --a1-only
  python3 ablation.py outputs/json/001.json -o outputs -p gpt --a2-only
  
  # Print prompts only (no generation)
  python3 ablation.py outputs/json/001.json --show-prompts

Ablation Configurations:
  A1: JSON only
  A2: JSON + base-code
"""
    )
    
    parser.add_argument("input", nargs="+", help="Input JSON file(s)")
    parser.add_argument("-o", "--output", help="Output base directory")
    parser.add_argument("-p", "--provider", default="gpt", 
                       choices=["gpt", "gpt-4o", "deepseek", "kimi-turbo", "claude", "glm"],
                       help="LLM provider to use")
    parser.add_argument("--a1-only", action="store_true", help="Only run A1 (JSON only)")
    parser.add_argument("--a2-only", action="store_true", help="Only run A2 (JSON + base-code)")
    parser.add_argument("--show-prompts", action="store_true", help="Print prompts and exit")
    parser.add_argument("--no-skip-existing", action="store_true", 
                       help="Force regenerate even if files exist")
    
    args = parser.parse_args()
    
    # Show prompts mode
    if args.show_prompts:
        json_path = args.input[0]
        basename = Path(json_path).stem
        base_code_path = Path(args.output) / "base-code" / f"{basename}.ets" if args.output else None
        print_prompts(json_path, str(base_code_path) if base_code_path else None)
        return
    
    if not args.output:
        print("Error: --output is required (unless using --show-prompts)")
        sys.exit(1)
    
    skip_existing = not args.no_skip_existing
    
    # Validate provider config
    try:
        get_model_config(args.provider)
    except ValueError as e:
        print(f"Error: {e}")
        sys.exit(1)
    
    # Process each input file
    for input_path in args.input:
        if not Path(input_path).exists():
            print(f"Error: File not found: {input_path}")
            continue
        
        if not input_path.endswith('.json'):
            print(f"Error: Input must be JSON file: {input_path}")
            continue
        
        basename = Path(input_path).stem
        base_code_path = Path(args.output) / "base-code" / f"{basename}.ets"
        
        print(f"\n[Ablation] {basename} [{args.provider}]")
        
        if args.a1_only:
            run_ablation_a1(input_path, args.output, args.provider, skip_existing)
            continue
        
        if args.a2_only:
            if base_code_path.exists():
                run_ablation_a2(input_path, str(base_code_path), args.output, args.provider, skip_existing)
            else:
                print(f"  Error: base-code not found for {basename}")
            continue
        
        run_ablation_a1(input_path, args.output, args.provider, skip_existing)
        
        if base_code_path.exists():
            run_ablation_a2(input_path, str(base_code_path), args.output, args.provider, skip_existing)
        else:
            print(f"  A2: Skip (base-code not found)")
    
    print("\n✓ Ablation study complete!")


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
"""Basic Swift to ArkTS Translator"""

import argparse
import os
import sys
from pathlib import Path
from dotenv import load_dotenv

load_dotenv()

# Model configurations
MODEL_CONFIGS = {
    "gpt": {
        "model": os.getenv("GPT_MODEL", "gpt-5.2-2025-12-11"),
        "api_key": os.getenv("GPT_API_KEY", ""),
        "base_url": os.getenv("GPT_BASE_URL", "https://xiaoai.plus/v1"),
    },
    "gpt-4o": {
        "model": os.getenv("GPT_4O_MODEL", "gpt-4o-2024-11-20"),
        "api_key": os.getenv("GPT_API_KEY", ""),
        "base_url": os.getenv("GPT_BASE_URL", "https://xiaoai.plus/v1"),
    },
    "gemini": {
        "model": os.getenv("GEMINI_MODEL", "gemini-3.1-pro-preview"),
        "api_key": os.getenv("GPT_API_KEY", ""),
        "base_url": os.getenv("GPT_BASE_URL", "https://xiaoai.plus/v1"),
    },
    "kimi-turbo": {
        "model": os.getenv("KIMI_TURBO_MODEL", "kimi-k2-turbo-preview"),
        "api_key": os.getenv("KIMI_API_KEY", ""),
        "base_url": os.getenv("KIMI_BASE_URL", "https://api.moonshot.cn/v1"),
    },
    "claude": {
        "model": os.getenv("CLAUDE_MODEL", "claude-opus-4-5-20251101"),
        "api_key": os.getenv("CLAUDE_API_KEY", ""),
        "base_url": os.getenv("CLAUDE_BASE_URL", "https://xiaoai.plus/v1"),
    },
    "glm": {
        "model": os.getenv("GLM_MODEL", "glm-5"),
        "api_key": os.getenv("GLM_API_KEY", ""),
        "base_url": "",  # GLM uses ZhipuAI client, not OpenAI
    },
}


BASIC_SYSTEM_PROMPT = "Convert Swift Compose UI code to ArkTS. Output code only."


def is_valid_file(filepath: str) -> bool:
    """Check if file exists and is valid"""
    if not os.path.exists(filepath):
        return False
    if os.path.getsize(filepath) == 0:
        return False
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read().strip()
        if not content or len(content) < 10:
            return False
    return True


def translate(Swift_code: str, provider: str = "kimi-turbo") -> str:
    """Translate Swift Compose to ArkTS using basic prompt"""
    
    if provider not in MODEL_CONFIGS:
        raise ValueError(f"Unknown provider: {provider}")
    
    config = MODEL_CONFIGS[provider]
    if not config["api_key"]:
        raise ValueError(f"API_KEY not set for {provider}")
    
    user_prompt = f"Swift:\n```Swift\n{Swift_code}\n```\n\nArkTS:"
    
    # GLM uses ZhipuAI client
    if provider == "glm":
        from zhipuai import ZhipuAI
        client = ZhipuAI(api_key=config["api_key"])
        
        response = client.chat.completions.create(
            model=config["model"],
            messages=[
                {"role": "system", "content": BASIC_SYSTEM_PROMPT},
                {"role": "user", "content": user_prompt}
            ],
            thinking={"type": "disabled"},  # Disable deep thinking
            temperature=float(os.getenv("TEMPERATURE", "0.0"))
        )
        return extract_code(response.choices[0].message.content)
    
    # OpenAI-compatible clients
    from openai import OpenAI
    client = OpenAI(api_key=config["api_key"], base_url=config["base_url"])
    
    temperature = float(os.getenv("TEMPERATURE", "0.0"))
    
    response = client.chat.completions.create(
        model=config["model"],
        messages=[
            {"role": "system", "content": BASIC_SYSTEM_PROMPT},
            {"role": "user", "content": user_prompt}
        ],
        temperature=temperature
    )
    
    return extract_code(response.choices[0].message.content)


def extract_code(raw: str) -> str:
    """Extract code from markdown blocks"""
    raw = raw.strip()
    if raw.startswith("```"):
        raw_body = raw[3:]
        newline_idx = raw_body.find("\n")
        if newline_idx != -1:
            remainder = raw_body[newline_idx + 1:]
            end_idx = remainder.rfind("```")
            return remainder[:end_idx].strip() if end_idx != -1 else remainder.strip()
        return raw_body.replace("```", "").strip()
    elif "```typescript" in raw:
        return raw.split("```typescript")[1].split("```")[0].strip()
    elif "```ets" in raw:
        return raw.split("```ets")[1].split("```")[0].strip()
    return raw


def main():
    parser = argparse.ArgumentParser(
        description="Basic Swift to ArkTS Translator",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  python3 basic_translate.py input.kt -o outputs/basic
  python3 basic_translate.py input.kt -o outputs/basic -p gpt
        """
    )
    parser.add_argument("input", nargs='+', help="Input Swift file(s) or directory(s)")
    parser.add_argument("-o", "--output", required=True, help="Output base directory (will create {provider}/ subdir)")
    parser.add_argument("-p", "--provider", 
                        choices=list(MODEL_CONFIGS.keys()), 
                        default="kimi-turbo",
                        help="LLM provider (default: kimi-turbo)")
    parser.add_argument("-f", "--force", action="store_true",
                        help="Force regenerate even if file exists")
    args = parser.parse_args()
    
    output_dir = os.path.join(args.output, args.provider)
    os.makedirs(output_dir, exist_ok=True)
    
    kt_files = []
    for inp in args.input:
        if os.path.isfile(inp):
            kt_files.append(inp)
        else:
            for root, _, files in os.walk(inp):
                for f in files:
                    if f.endswith('.kt'):
                        kt_files.append(os.path.join(root, f))
    
    if not kt_files:
        print(f"Error: No .kt files found in {args.input}")
        sys.exit(1)
    
    print(f"Found {len(kt_files)} Swift file(s)")
    print(f"Output directory: {output_dir}")
    print(f"Provider: {args.provider} ({MODEL_CONFIGS[args.provider]['model']})")
    print()
    
    skipped = 0
    failed = 0
    success = 0
    
    for kt_file in kt_files:
        basename = Path(kt_file).stem
        output_path = os.path.join(output_dir, f"{basename}.ets")
        
        if not args.force and is_valid_file(output_path):
            print(f"[{basename}.kt] ✓ Skip (already exists)")
            skipped += 1
            continue
        
        print(f"[{basename}.kt]", end=' ', flush=True)
        
        try:
            with open(kt_file, 'r', encoding='utf-8') as f:
                Swift_code = f.read()
            
            print(f"translating...", end=' ', flush=True)
            arkts_code = translate(Swift_code, args.provider)
            
            if not arkts_code or len(arkts_code.strip()) < 10:
                print(f"✗ Failed (empty output)")
                failed += 1
                continue
            
            with open(output_path, 'w', encoding='utf-8') as f:
                f.write(arkts_code)
            
            print(f"✓ Saved ({len(arkts_code.splitlines())} lines)")
            success += 1
            
        except Exception as e:
            print(f"✗ Error: {e}")
            failed += 1
    
    print(f"\n{'='*50}")
    print(f"Completed: {success} success, {skipped} skipped, {failed} failed / {len(kt_files)} total")
    print(f"Output: {output_dir}/")


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
"""Kotlin to ArkTS Migration Pipeline - Step-by-step output."""

import argparse
import json
import os
import re
import sys
from typing import Dict, List, Any, Optional
from pathlib import Path

from tree_kt import KotlinUIParser
from generator import ArkTSGeneratorV3
from dotenv import load_dotenv

load_dotenv()

MODEL_CONFIGS = {
    "gpt": {
        "model": os.getenv("GPT_MODEL", ""),
        "api_key": os.getenv("GPT_API_KEY", ""),
        "base_url": os.getenv("GPT_BASE_URL", ""),
    },
    "gpt-4o": {
        "model": os.getenv("GPT_4O_MODEL", ""),
        "api_key": os.getenv("GPT_API_KEY", ""),
        "base_url": os.getenv("GPT_BASE_URL", ""),
    },
    "deepseek": {
        "model": os.getenv("DEEPSEEK_MODEL", ""),
        "api_key": os.getenv("DEEPSEEK_API_KEY", ""),
        "base_url": os.getenv("DEEPSEEK_BASE_URL", ""),
    },
    "kimi-turbo": {
        "model": os.getenv("KIMI_TURBO_MODEL", ""),
        "api_key": os.getenv("KIMI_API_KEY", ""),
        "base_url": os.getenv("KIMI_BASE_URL", ""),
    },
    "claude": {
        "model": os.getenv("CLAUDE_MODEL", ""),
        "api_key": os.getenv("CLAUDE_API_KEY", ""),
        "base_url": os.getenv("CLAUDE_BASE_URL", ""),
    },
    "glm": {
        "model": os.getenv("GLM_MODEL", ""),
        "api_key": os.getenv("GLM_API_KEY", ""),
        "base_url": "",
    },
}


def get_model_config(provider: str) -> dict:
    provider = provider.lower()
    if provider not in MODEL_CONFIGS:
        raise ValueError(f"Unknown provider: {provider}. Available: {', '.join(MODEL_CONFIGS.keys())}")
    
    config = MODEL_CONFIGS[provider]
    if not config["api_key"]:
        raise ValueError(f"API_KEY not set for provider: {provider}")
    
    return config


ONE_SHOT_EXAMPLE = '''
skeleton:
@Entry
@Component
struct CompactOneShot {
  @State v: number = 50

  build() {
    // === Stack ===
    // props: { alignContent: Alignment.BottomEnd }
    // children: 2
    Stack() {
      // === Column ===
      // props: { space: 12 }
      // modifier: { width: '100%', height: '100%', padding: 16, backgroundColor: '#F5F5F5' }
      // children: 3
      Column() {
        // === Row ===
        // props: { space: 12 }
        // modifier: { width: '100%', height: 56, padding: 16, backgroundColor: '#FFF', shadow: { radius: 4, color: '#1F000000' } }
        // children: 3
        Row() {
          // === Text ===
          // props: { text: 'Title' }
          // modifier: { fontSize: 20, fontWeight: FontWeight.Medium }
          Text() {}
          // === Blank ===
          Blank() {}
          // === Image ===
          // modifier: { width: 24, height: 24, backgroundColor: '#E0E0E0' }
          Image() {}
        }

        // === List ===
        // props: { space: 8 }
        // modifier: { width: '100%', layoutWeight: 1 }
        // children: 5
        List() {
          ListItem() {
            // === TextInput ===
            // modifier: { width: '100%', height: 44, backgroundColor: '#FFF', borderRadius: 8 }
            TextInput() {}
          }
          ListItem() {
            // === Divider ===
            // modifier: { height: 1, color: '#E0E0E0' }
            Divider() {}
          }
          ListItem() {
            // === Progress ===
            // props: { value: this.v, total: 100, type: ProgressType.Linear }
            // modifier: { width: '100%', height: 4, color: '#6750A4' }
            Progress() {}
          }
          ListItem() {
            // === Slider ===
            // props: { value: this.v, min: 0, max: 100 }
            // modifier: { width: '100%' }
            Slider() {}
          }
          ListItem() {
            // === Grid ===
            // props: { columnsTemplate: '1fr 1fr', columnsGap: 8 }
            // modifier: { width: '100%' }
            // children: 2
            Grid() {
              GridItem() {
                // === Column ===
                // modifier: { backgroundColor: '#FFF', padding: 20, borderRadius: 8 }
                // children: 1
                Column() {
                  // === Text ===
                  // props: { text: 'A' }
                  Text() {}
                }
              }
              GridItem() {
                Column() {
                  // === Text ===
                  // props: { text: 'B' }
                  Text() {}
                }
              }
            }
          }
        }

        // === Blank ===
        Blank() {}
      }

      // === Button ===
      // modifier: { width: 56, height: 56, backgroundColor: '#EADDFF', fontColor: '#FFF', borderRadius: 16, shadow: { radius: 6, color: '#3F000000' }, margin: 24 }
      // children: 1
      Button() {
        // === Text ===
        // props: { text: 'Button' }
        Text() {}
      }
    }
    // modifier: { width: '100%', height: '100%' }
  }
}

ArkTS:
@Entry
@Component
struct CompactOneShot {
  @State v: number = 50

  build() {
    Stack({ alignContent: Alignment.BottomEnd }) {
      Column({ space: 12 }) {
        Row({ space: 12 }) {
          Text('Title').fontSize(20).fontWeight(FontWeight.Medium)
          Blank()
          Image('').width(24).height(24).backgroundColor('#E0E0E0')
        }.width('100%').height(56).padding(16).backgroundColor('#FFF').shadow({ radius: 4, color: '#1F000000' })

        List({ space: 8 }) {
          ListItem() { TextInput().width('100%').height(44).backgroundColor('#FFF').borderRadius(8) }
          ListItem() { Divider().height(1).color('#E0E0E0') }
          ListItem() { Progress({ value: this.v, total: 100, type: ProgressType.Linear }).width('100%').height(4).color('#6750A4') }
          ListItem() { Slider({ value: this.v, min: 0, max: 100 }).width('100%') }
          ListItem() {
            Grid() {
              GridItem() { Column() { Text('A') }.backgroundColor('#FFF').padding(20).borderRadius(8) }
              GridItem() { Column() { Text('B') }.backgroundColor('#FFF').padding(20).borderRadius(8) }
            }.columnsTemplate('1fr 1fr').columnsGap(8).width('100%')
          }
        }.width('100%').layoutWeight(1)

        Blank()
      }.width('100%').height('100%').padding(16).backgroundColor('#F5F5F5')

      Button() { Text('Button') }.width(56).height(56).backgroundColor('#EADDFF').fontColor('#FFF').borderRadius(16).shadow({ radius: 6, color: '#3F000000' }).margin(24)
    }.width('100%').height('100%')
  }
}'''


def call_llm(ui_data: dict, base_code: str, model_config: dict, provider: str = "") -> str:
    colors = ui_data.get("theme", {}).get("colors", {})
    color_refs = "\n".join([f"  {k}: {v}" for k, v in colors.items()]) if colors else "  None"

    system_prompt = f"""You are an expert ArkTS developer. Convert this ArkTS-style Kotlin Compose UI skeleton to compilable ArkTS code.

Follow the code style and patterns shown in the example below:

{ONE_SHOT_EXAMPLE}

Output compilable ArkTS code only."""

    user_prompt = f"""Generate compilable ArkTS code based on the ArkTS-style Kotlin Compose UI skeleton below.

**Theme Colors:**
{color_refs}

**UI Structure with Metadata:**
```typescript
{base_code}
```

Requirements:
1. Use ONLY: Stack, Column, Row, Grid, List, Text, Button, Image, Progress, Slider, Blank, Divider, TextInput
2. Column/Row: constructor takes {{ space: N }}, chain methods (alignItems, width, etc.) come AFTER {{ }}
3. List children MUST use ListItem(), Grid children MUST use GridItem()
4. State variables use this. prefix
5. Replace all // comments with actual implementation based on the metadata

Output compilable ArkTS code only:"""

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
            temperature=float(os.getenv("TEMPERATURE", "0.1"))
        )
        return extract_code(response.choices[0].message.content)
    
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


def extract_code(raw: str) -> str:
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


def post_fix(code: str) -> str:
    """Apply deterministic fixes to ArkTS code."""
    # Constant Inlining
    def extract_nested_classes(code: str) -> str:
        replacements = []
        outer_pattern = r'class\s+(\w+)\s*\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}'
        
        for match in re.finditer(outer_pattern, code, re.DOTALL):
            outer_name = match.group(1)
            outer_body = match.group(2)
            
            inner_pattern = r'static\s+(\w+)\s*=\s*class\s*\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}'
            for inner_match in re.finditer(inner_pattern, outer_body):
                inner_name = inner_match.group(1)
                inner_body = inner_match.group(2)
                
                prop_pattern = r'static\s+(\w+)\s*:\s*(?:string|number)\s*=\s*([\'"]?[^\'"\s;]+[\'"]?)'
                for prop_match in re.finditer(prop_pattern, inner_body):
                    prop_name = prop_match.group(1)
                    value = prop_match.group(2).strip()
                    full_ref = f'{outer_name}.{inner_name}.{prop_name}'
                    replacements.append((full_ref, value))
            
            simple_pattern = r'static\s+(\w+)\s*:\s*(?:string|number)\s*=\s*([\'"][^\'"]+[\'"]|\d+)'
            for prop_match in re.finditer(simple_pattern, outer_body):
                prop_name = prop_match.group(1)
                value = prop_match.group(2)
                is_nested = any(f'static {prop_name}' in inner_match.group(2) 
                               for inner_match in re.finditer(inner_pattern, outer_body))
                if not is_nested:
                    full_ref = f'{outer_name}.{prop_name}'
                    replacements.append((full_ref, value))
        
        replacements.sort(key=lambda x: len(x[0]), reverse=True)
        
        for ref, val in replacements:
            code = re.sub(rf'\b{re.escape(ref)}\b', val, code)
        
        return code
    
    code = extract_nested_classes(code)
    
    for _ in range(5):
        code = re.sub(r'class\s+\w+\s*\{[^{}]*\}', '', code)
        code = re.sub(r'class\s+\w+\s*\{[^{}]*(?:\{[^{}]*\}[^{}]*){1,5}\}', '', code, flags=re.DOTALL)
    
    code = re.sub(r'\n\s*\n\s*\n+', '\n\n', code)

    # Lexical Rectification
    code = re.sub(r'(\bthis\.)?(\w+)\.toInt\(\)', r'\1\2', code)
    
    code = re.sub(
        r'(\bthis\.\w+)\.forEach\(\((\w+):\s*(\w+),\s*(\w+):\s*number\)\s*=>\s*\{',
        r'ForEach(\1, (\2: \3, \4: number) => {',
        code
    )
    
    code = re.sub(r'\bAlignment\.CenterStart\b', 'Alignment.Start', code)
    code = re.sub(r'\bAlignment\.CenterEnd\b', 'Alignment.End', code)
    code = re.sub(r'\bAlignment\.TopCenter\b', 'Alignment.Top', code)
    code = re.sub(r'\bAlignment\.BottomCenter\b', 'Alignment.Bottom', code)
    
    code = re.sub(r'\bFontWeight\.SemiBold\b', 'FontWeight.Medium', code)
    
    code = re.sub(
        r'Button\(\(\)\s*=>\s*\{([^{}]*)\}\)\s*\{([^{}]*(?:\{[^{}]*\}[^{}]*)*)\}',
        r'Button() {\2}.onClick(() => {\1})',
        code, flags=re.DOTALL
    )
    
    def fix_gradient(match):
        colors_str = match.group(2)
        colors = [c.strip() for c in re.findall(r'[\'"][^\'"]+[\'"]', colors_str)]
        if len(colors) < 2:
            return match.group(0)
        new_colors = [f'[{c}, {i/(len(colors)-1):.1f}]' for i, c in enumerate(colors)]
        return f'{match.group(1)}[{", ".join(new_colors)}]'
    code = re.sub(r'(colors:\s*)\[([\'"][^\'"]+[\'"](?:,\s*[\'"][^\'"]+[\'"])+)\]', fix_gradient, code)

    # Layout Property Rectification
    def expand_padding(match):
        prop, content = match.group(1), match.group(2)
        h = re.search(r'horizontal\s*:\s*(\d+)', content)
        v = re.search(r'vertical\s*:\s*(\d+)', content)
        h_val, v_val = (h.group(1) if h else None), (v.group(1) if v else None)
        
        if h_val and v_val and h_val == v_val:
            return f'.{prop}({h_val})'
        parts = []
        if h_val: parts.extend([f'left: {h_val}', f'right: {h_val}'])
        if v_val: parts.extend([f'top: {v_val}', f'bottom: {v_val}'])
        return f'.{prop}({{{", ".join(parts)}}})' if parts else match.group(0)
    code = re.sub(r'\.(padding|margin)\(\s*\{([^}]*(?:horizontal|vertical)[^}]*)\}\s*\)', expand_padding, code)

    # Structural Integrity Validation
    def fix_blank_in_illegal_container(code):
        lines = code.split('\n')
        result = []
        containers = []
        brace_level = 0
        legal_containers = {'Row', 'Column'}
        all_containers = ['Stack', 'Column', 'Row', 'Grid', 'List']
        
        for line in lines:
            indent = len(line) - len(line.lstrip())
            
            for ctype in all_containers:
                if ctype + '(' in line and '{' in line:
                    open_count = line.count('{')
                    close_count = line.count('}')
                    net = open_count - close_count
                    if net > 0:
                        containers.append((brace_level, ctype))
                    elif open_count > 0 and line.find('{') < line.rfind('}'):
                        containers.append((brace_level, ctype))
                    break
            
            net_change = line.count('{') - line.count('}')
            if net_change != 0:
                new_level = brace_level + net_change
                if new_level < brace_level:
                    while containers and containers[-1][0] >= new_level:
                        containers.pop()
                brace_level = new_level
            
            should_replace = False
            if containers:
                if containers[-1][1] not in legal_containers:
                    should_replace = True
            
            if should_replace and 'Blank()' in line:
                line = line.replace('Blank()', 'Column()')
            
            result.append(line)
        
        return '\n'.join(result)
    
    code = fix_blank_in_illegal_container(code)
    
    lines = code.split('\n')
    fixed_lines = []
    for line in lines:
        if '=>' in line or not re.match(r'^\s*\.', line):
            fixed_lines.append(line)
            continue
        open_c = line.count('{')
        close_c = line.count('}')
        if open_c > close_c and line.rstrip().endswith(')'):
            line = line.rstrip()[:-1] + '}' * (open_c - close_c) + ')'
        fixed_lines.append(line)
    code = '\n'.join(fixed_lines)

    return code


def is_valid_file(filepath: Path) -> bool:
    if not filepath.exists():
        return False
    if filepath.stat().st_size == 0:
        return False
    try:
        with open(filepath, 'r', encoding='utf-8') as f:
            content = f.read().strip()
            if len(content) < 50 or '@' not in content:
                return False
    except:
        return False
    return True


def step1_parse(input_path: str, output_base: str, skip_existing: bool = True) -> Optional[dict]:
    basename = Path(input_path).stem
    json_path = Path(output_base) / "json" / f"{basename}.json"
    
    if skip_existing and is_valid_file(json_path):
        print(f"  Step 1: JSON exists, loading...")
        with open(json_path, 'r', encoding='utf-8') as f:
            ui_data = json.load(f)
        count = sum(1 for _ in iterate_all(ui_data.get("ui_structure", [])))
        print(f"    Loaded: {count} components")
        return ui_data
    
    print(f"  Step 1: Parsing Kotlin...")
    with open(input_path, 'r', encoding='utf-8') as f:
        source = f.read()

    parser = KotlinUIParser()
    ui_data = parser.parse(source)
    
    count = sum(1 for _ in iterate_all(ui_data.get("ui_structure", [])))
    print(f"    Parsed: {count} components")

    json_path.parent.mkdir(parents=True, exist_ok=True)
    with open(json_path, 'w', encoding='utf-8') as f:
        json.dump(ui_data, f, indent=2, ensure_ascii=False)
    print(f"    Saved: {json_path}")
    return ui_data


def step2_base_code(input_path: str, output_base: str, skip_existing: bool = True) -> Optional[str]:
    input_p = Path(input_path)
    if input_p.suffix == '.json' and input_p.exists():
        json_path = input_p
        basename = json_path.stem
        print(f"  Step 2: Using specified JSON: {json_path}")
    else:
        basename = input_p.stem
        json_path = Path(output_base) / "json" / f"{basename}.json"
        if not json_path.exists():
            print(f"  [Error] Step 1 output not found: {json_path}")
            print(f"     Run: pipeline_v4.py {input_path} -o {output_base} --step 1")
            return None
    
    base_path = Path(output_base) / "base-code" / f"{basename}.ets"
    
    if skip_existing and is_valid_file(base_path):
        print(f"  Step 2: Base code exists, loading...")
        with open(base_path, 'r', encoding='utf-8') as f:
            base_code = f.read()
        return base_code
    
    print(f"  Step 2: Loading JSON and generating base code...")
    with open(json_path, 'r', encoding='utf-8') as f:
        ui_data = json.load(f)
    
    generator = ArkTSGeneratorV3("mappings/components.json")
    base_code = generator.generate(ui_data)
    
    base_path.parent.mkdir(parents=True, exist_ok=True)
    with open(base_path, 'w', encoding='utf-8') as f:
        f.write(base_code)
    print(f"    Saved: {base_path}")
    return base_code


def step3_llm(input_path: str, output_base: str, provider: str, skip_existing: bool = True) -> Optional[str]:
    input_p = Path(input_path)
    if input_p.suffix == '.ets' and input_p.exists() and 'base-code' not in str(input_p):
        basename = input_p.stem
        base_path = input_p
        print(f"  Step 3: Using specified base-code: {base_path}")
        json_path = Path(output_base) / "json" / f"{basename}.json"
    else:
        basename = input_p.stem
        json_path = Path(output_base) / "json" / f"{basename}.json"
        base_path = Path(output_base) / "base-code" / f"{basename}.ets"
    
    llm_path = Path(output_base) / provider / f"{basename}.ets"
    
    if not json_path.exists():
        print(f"  [Error] JSON not found: {json_path}")
        return None
    if not base_path.exists():
        print(f"  [Error] Base code not found: {base_path}")
        return None
    
    if skip_existing and is_valid_file(llm_path):
        print(f"  Step 3: LLM output exists, loading...")
        with open(llm_path, 'r', encoding='utf-8') as f:
            llm_code = f.read()
        return llm_code
    
    print(f"  Step 3: LLM generation ({provider})...")
    with open(json_path, 'r', encoding='utf-8') as f:
        ui_data = json.load(f)
    with open(base_path, 'r', encoding='utf-8') as f:
        base_code = f.read()
    
    model_config = get_model_config(provider)
    llm_code = call_llm(ui_data, base_code, model_config, provider)
    
    if not llm_code or len(llm_code.strip()) < 50:
        print(f"    [Failed] Empty output from LLM")
        return None
    
    llm_path.parent.mkdir(parents=True, exist_ok=True)
    with open(llm_path, 'w', encoding='utf-8') as f:
        f.write(llm_code)
    print(f"    Saved: {llm_path}")
    return llm_code


def step4_post_fix(input_path: str, output_base: str, provider: str, skip_existing: bool = True) -> Optional[str]:
    input_p = Path(input_path)
    if input_p.suffix == '.ets' and input_p.exists():
        llm_path = input_p
        basename = llm_path.stem
        if provider in str(llm_path.parent):
            post_path = Path(output_base) / f"{provider}-post" / f"{basename}.ets"
        else:
            post_path = Path(output_base) / f"{basename}-post.ets"
        print(f"  Step 4: Using specified LLM output: {llm_path}")
    else:
        basename = input_p.stem
        llm_path = Path(output_base) / provider / f"{basename}.ets"
        post_path = Path(output_base) / f"{provider}-post" / f"{basename}.ets"
        
        if not llm_path.exists():
            print(f"  [Error] Step 3 output not found: {llm_path}")
            print(f"     You can also specify the LLM file directly: pipeline_v4.py path/to/llm.ets -o {output_base} --step 4")
            return None
    
    print(f"  Step 4: Post-fix...")
    with open(llm_path, 'r', encoding='utf-8') as f:
        llm_code = f.read()
    
    fixed_code = post_fix(llm_code)
    
    if not fixed_code or len(fixed_code.strip()) < 50:
        print(f"    [Failed] Post-fix produced empty output")
        return None
    
    if not skip_existing or not post_path.exists():
        post_path.parent.mkdir(parents=True, exist_ok=True)
        with open(post_path, 'w', encoding='utf-8') as f:
            f.write(fixed_code)
        print(f"    Saved: {post_path}")
    else:
        print(f"    Skip: {post_path} exists")
    
    return fixed_code


def process_file(input_path: str, output_base: str, provider: str = "gpt", 
                 skip_existing: bool = True, step: Optional[int] = None) -> bool:
    basename = Path(input_path).stem
    
    post_path = Path(output_base) / f"{provider}-post" / f"{basename}.ets"
    if skip_existing and is_valid_file(post_path) and step is None:
        print(f"[Skip] {basename}.kt [{provider}] - final output exists")
        return True
    
    try:
        print(f"\n[Processing] {basename}.kt [{provider}]" + (f" [Step {step}]" if step else " [All steps]"))
        
        if step == 1:
            result = step1_parse(input_path, output_base, skip_existing)
            return result is not None
        
        elif step == 2:
            result = step2_base_code(input_path, output_base, skip_existing)
            return result is not None
        
        elif step == 3:
            result = step3_llm(input_path, output_base, provider, skip_existing)
            return result is not None
        
        elif step == 4:
            result = step4_post_fix(input_path, output_base, provider, skip_existing)
            return result is not None
        
        ui_data = step1_parse(input_path, output_base, skip_existing)
        if ui_data is None:
            return False
        
        base_code = step2_base_code(input_path, output_base, skip_existing)
        if base_code is None:
            return False
        
        llm_code = step3_llm(input_path, output_base, provider, skip_existing)
        if llm_code is None:
            return False
        
        fixed_code = step4_post_fix(input_path, output_base, provider, skip_existing)
        if fixed_code is None:
            return False

        print(f"  Done: {basename}")
        return True

    except Exception as e:
        print(f"  Error: {e}")
        import traceback
        traceback.print_exc()
        return False


def iterate_all(nodes: List[Dict]):
    for node in nodes:
        yield node
        yield from iterate_all(node.get("children", []))


def main():
    parser = argparse.ArgumentParser(
        description="Kotlin to ArkTS - Step-by-step pipeline v4"
    )
    parser.add_argument("input", help="Input Kotlin file or directory")
    parser.add_argument("-o", "--output", required=True, help="Output base directory")
    parser.add_argument("-p", "--provider", choices=list(MODEL_CONFIGS.keys()), default="gpt",
                        help=f"LLM provider to use (default: gpt)")
    parser.add_argument("--step", type=int, choices=[1, 2, 3, 4], default=None,
                        help="Run only this step (1-4). If not set, run all steps.")
    parser.add_argument("--no-skip-existing", action="store_true",
                        help="Force regenerate even if files exist")
    args = parser.parse_args()
    
    skip_existing = not args.no_skip_existing

    if not os.path.exists(args.input):
        print(f"Error: Input not found: {args.input}")
        sys.exit(1)

    if os.path.isfile(args.input):
        success = process_file(args.input, args.output, args.provider, skip_existing, args.step)
        sys.exit(0 if success else 1)
    else:
        kt_files = []
        for root, _, files in os.walk(args.input):
            for f in files:
                if f.endswith('.kt'):
                    kt_files.append(os.path.join(root, f))

        if not kt_files:
            print("No .kt files found")
            sys.exit(1)

        print(f"Found {len(kt_files)} Kotlin files")

        success = 0
        step_info = f" [Step {args.step}]" if args.step else " [All steps]"
        print(f"Processing with{step_info}\n")
        
        for kt_file in kt_files:
            if process_file(kt_file, args.output, args.provider, skip_existing, args.step):
                success += 1

        print(f"\nCompleted: {success}/{len(kt_files)} files")


if __name__ == "__main__":
    main()

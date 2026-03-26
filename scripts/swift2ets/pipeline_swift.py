#!/usr/bin/env python3
"""
SwiftUI to ArkTS Migration Pipeline - Adapted from Kotlin pipeline v4
Step-by-step output with organized folders
"""

import argparse
import json
import os
import re
import sys
from typing import Dict, List, Any, Optional
from pathlib import Path

from tree_swift import SwiftUIExtractor
from generator_swift import SwiftArkTSGenerator
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
        "base_url": "",  # GLM uses ZhipuAI client
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
    """Single round: Generate compilable ArkTS code from SwiftUI base-code"""
    colors = ui_data.get("theme", {}).get("colors", {})
    color_refs = "\n".join([f"  {k}: {v}" for k, v in colors.items()]) if colors else "  None"

    system_prompt = f"""You are an expert ArkTS developer. Convert this ArkTS-style SwiftUI Compose s ke len ton to compilable ArkTS code.

Follow the code style and patterns shown in the example below:

{ONE_SHOT_EXAMPLE}

Output compilable ArkTS code only."""

    user_prompt = f"""Generate compilable ArkTS code based on the ArkTS-style SwiftUI Compose skeleton below.

**Theme Colors:**
{color_refs}

**ArkTS-style Kotlin Compose skeleton:**
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


    temperature = float(os.getenv("TEMPERATURE", "0.0"))
    max_tokens = os.getenv("MAX_TOKENS")
    top_p = os.getenv("TOP_P")
    

    def build_kwargs(base_kwargs):
        if max_tokens:
            base_kwargs["max_tokens"] = int(max_tokens)
        if top_p:
            base_kwargs["top_p"] = float(top_p)
        return base_kwargs
    
    # GLM uses ZhipuAI client
    if provider == "glm":
        from zhipuai import ZhipuAI
        client = ZhipuAI(api_key=model_config["api_key"])
        
        kwargs = build_kwargs({
            "model": model_config["model"],
            "messages": [
                {"role": "system", "content": system_prompt},
                {"role": "user", "content": user_prompt}
            ],
            "thinking": {"type": "disabled"},
            "temperature": temperature
        })
        
        response = client.chat.completions.create(**kwargs)
        return extract_code(response.choices[0].message.content)
    
    # OpenAI-compatible clients
    from openai import OpenAI
    client = OpenAI(
        api_key=model_config["api_key"], 
        base_url=model_config["base_url"]
    )
    
    kwargs = build_kwargs({
        "model": model_config["model"],
        "messages": [
            {"role": "system", "content": system_prompt},
            {"role": "user", "content": user_prompt}
        ],
        "temperature": temperature
    })
    
    response = client.chat.completions.create(**kwargs)
    return extract_code(response.choices[0].message.content)


def extract_code(raw: str) -> str:
    """Extract code from response"""
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


def post_fix(code: str, source_type: str = "swift") -> str:
    # ========== Constant Inlining ==========
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

    # ========== Lexical Rectification ==========
    def split_frame(match) -> str:
        params = match.group(1)
        width = re.search(r'width\s*:\s*([\'"]?[\w\.]+[\'"]?|\d+)', params)
        height = re.search(r'height\s*:\s*([\'"]?[\w\.]+[\'"]?|\d+)', params)
        result = ""
        if width: 
            result += f".width({width.group(1)})"
        if height: 
            result += f".height({height.group(1)})"
        if re.search(r'maxWidth\s*:\s*\.infinity', params):
            result += ".layoutWeight(1)"
        return result
    
    def fix_color_alpha(match) -> str:
        color = match.group(1)
        if len(color) == 9 and color[0] == '#':
            return f"'#{color[3:]}{color[1:3]}'"
        return match.group(0)
    
    def fix_swift_button(code: str) -> str:
        result = []
        i = 0
        while i < len(code):
            match = re.search(r'Button\(\s*\(\)\s*=>\s*\{', code[i:])
            if not match:
                result.append(code[i:])
                break
            
            start = i + match.start()
            result.append(code[i:start])
            
            brace_start = i + match.end()
            brace_count = 1
            pos = brace_start
            
            while pos < len(code) and brace_count > 0:
                if code[pos] == '{':
                    brace_count += 1
                elif code[pos] == '}':
                    brace_count -= 1
                pos += 1
            
            action = code[brace_start:pos-1].strip()
            
            while pos < len(code) and (code[pos].isspace() or code[pos] == ')'):
                pos += 1
            
            if pos >= len(code) or code[pos] != '{':
                result.append(code[start:pos])
                i = pos
                continue
            
            pos += 1
            label_start = pos
            brace_count = 1
            
            while pos < len(code) and brace_count > 0:
                if code[pos] == '{':
                    brace_count += 1
                elif code[pos] == '}':
                    brace_count -= 1
                pos += 1
            
            label = code[label_start:pos-1].strip()
            
            fixed = f'Button() {{\n  {label}\n}}.onClick(() => {{\n  {action}\n}})'
            result.append(fixed)
            i = pos
        
        return ''.join(result)
    
    def fix_constructor_onchange(code: str) -> str:
        pattern = r'([A-Z][a-zA-Z0-9]*)\s*\(\s*\{'
        result = []
        last_end = 0
        
        for match in re.finditer(pattern, code):
            start = match.start()
            component_name = match.group(1)
            result.append(code[last_end:start])
            
            brace_count = 1
            pos = match.end()
            content_start = pos
            
            while pos < len(code) and brace_count > 0:
                if code[pos] == '{':
                    brace_count += 1
                elif code[pos] == '}':
                    brace_count -= 1
                pos += 1
            
            if brace_count != 0:
                result.append(code[start:pos])
                last_end = pos
                continue
            
            content = code[content_start:pos-1]
            
            onchange_match = re.search(
                r'(,\s*)?onChange\s*:\s*(\([^)]*\)\s*=>\s*\{[^{}]*\})(\s*,)?', 
                content
            )
            if not onchange_match:
                result.append(code[start:pos])
                last_end = pos
                continue
            
            before = content[:onchange_match.start()]
            after = content[onchange_match.end():]
            
            new_content = before + after
            new_content = re.sub(r',\s*}', '}', new_content)
            new_content = re.sub(r'{\s*,', '{', new_content)
            new_content = re.sub(r',,', ',', new_content)
            new_content = re.sub(r',\s*$', '', new_content)
            
            onchange_code = onchange_match.group(2)
            replacement = f'{component_name}({{{new_content}}}).onChange({onchange_code})'
            result.append(replacement)
            
            while pos < len(code) and code[pos].isspace():
                pos += 1
            if pos < len(code) and code[pos] == ')':
                pos += 1
            
            last_end = pos
        
        result.append(code[last_end:])
        return ''.join(result)
    
    code = re.sub(r'@State\s+private\s+', '@State ', code)
    code = re.sub(r'@State\s+public\s+', '@State ', code)
    code = re.sub(r'@State\s+var\s+', '@State ', code)
    code = re.sub(r'@State\s+let\s+', '@State ', code)
    
    code = re.sub(r'\bVStack\s*\(', 'Column(', code)
    code = re.sub(r'\bHStack\s*\(', 'Row(', code)
    code = re.sub(r'\bZStack\s*\(', 'Stack(', code)
    code = re.sub(r'\bSpacer\s*\(\s*\)', 'Blank()', code)
    
    code = re.sub(r'\.frame\s*\(\s*([^)]+)\s*\)', split_frame, code)
    
    code = re.sub(r"['\"](#[0-9A-Fa-f]{8})['\"]", fix_color_alpha, code)
    
    code = re.sub(r'\.background\s*\(\s*Color\.(\w+)\s*\)', r'.backgroundColor("\1")', code)
    code = re.sub(r'\.foregroundColor\s*\(\s*Color\.(\w+)\s*\)', r'.fontColor("\1")', code)
    
    code = re.sub(r'\bself\.', 'this.', code)

    code = re.sub(r'\bFontWeight\.SemiBold\b', 'FontWeight.Medium', code)
    code = re.sub(r'\bFontWeight\.Regular\b', 'FontWeight.Normal', code)
    
    code = re.sub(r'\bAlignment\.CenterStart\b', 'Alignment.Start', code)
    code = re.sub(r'\bAlignment\.CenterEnd\b', 'Alignment.End', code)
    code = re.sub(r'\bAlignment\.TopCenter\b', 'Alignment.Top', code)
    code = re.sub(r'\bAlignment\.BottomCenter\b', 'Alignment.Bottom', code)
    
    code = re.sub(r'\bHorizontalAlign\.Leading\b', 'HorizontalAlign.Start', code)
    code = re.sub(r'\bHorizontalAlign\.Trailing\b', 'HorizontalAlign.End', code)
    
    code = fix_swift_button(code)
    
    code = re.sub(
        r'ForEach\s*\(\s*(\w+)\s*\)\s*\{\s*(\w+)\s*,\s*(\w+)\s+in',
        r'ForEach(this.\1, (\2: any, \3: number) => {',
        code
    )
    code = re.sub(
        r'ForEach\s*\(\s*(\w+)\s*\)\s*\{\s*(\w+)\s+in',
        r'ForEach(this.\1, (\2: any, index: number) => {',
        code
    )
    
    code = fix_constructor_onchange(code)

    # ========== Layout Property Rectification ==========
    def expand_swift_padding(match) -> str:
        edges_str = match.group(1)
        val = match.group(2)
        edges = []
        edge_matches = re.findall(r'\.(\w+)', edges_str)
        mapping = {
            'top': 'top', 'bottom': 'bottom', 
            'leading': 'left', 'trailing': 'right',
            'left': 'left', 'right': 'right',
            'vertical': 'vertical', 'horizontal': 'horizontal',
            'all': ''
        }
        for e in edge_matches:
            if e == 'all':
                return f".padding({val})"
            if e in mapping:
                edges.append(f"{mapping[e]}: {val}")
        if edges:
            return f".padding({{{', '.join(edges)}}})"
        return match.group(0)
    
    code = re.sub(r'\.padding\s*\(\s*\[([^\]]+)\]\s*,\s*(\d+)\s*\)', expand_swift_padding, code)
    code = re.sub(
        r'\.padding\s*\(\s*\.(\w+)\s*,\s*(\d+)\s*\)',
        lambda m: f".padding({{ {'top' if m.group(1)=='top' else 'bottom' if m.group(1)=='bottom' else 'left' if m.group(1) in ['leading','left'] else 'right' if m.group(1) in ['trailing','right'] else m.group(1)}: {m.group(2)} }})",
        code
    )

    # ========== Structural Integrity Validation ==========
    def fix_blank_in_illegal_container(code: str) -> str:
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
    
    def balance_modifiers(code: str) -> str:
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
        return '\n'.join(fixed_lines)
    
    code = fix_blank_in_illegal_container(code)
    
    code = balance_modifiers(code)
    
    code = re.sub(r'\n{3,}', '\n\n', code)
    
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
    """Step 1: Parse SwiftUI → JSON
    Input: input.swift
    Output: json/input.json
    """
    basename = Path(input_path).stem
    json_path = Path(output_base) / "json" / f"{basename}.json"
    
    if skip_existing and is_valid_file(json_path):
        print(f"  Step 1: JSON exists, loading...")
        with open(json_path, 'r', encoding='utf-8') as f:
            ui_data = json.load(f)
        count = sum(1 for _ in iterate_all(ui_data.get("ui_structure", [])))
        print(f"    Loaded: {count} components")
        return ui_data
    
    print(f"  Step 1: Parsing SwiftUI...")
    extractor = SwiftUIExtractor()
    ui_data = extractor.analyze(input_path)
    
    if "error" in ui_data:
        print(f"    ✗ Error: {ui_data['error']}")
        return None
    
    count = sum(1 for _ in iterate_all(ui_data.get("ui_structure", [])))
    print(f"    Parsed: {count} components")

    # Save JSON
    json_path.parent.mkdir(parents=True, exist_ok=True)
    with open(json_path, 'w', encoding='utf-8') as f:
        json.dump(ui_data, f, indent=2, ensure_ascii=False)
    print(f"    Saved: {json_path}")
    return ui_data


def step2_base_code(input_path: str, output_base: str, skip_existing: bool = True) -> Optional[str]:
    """Step 2: JSON → Base code
    Input: input.swift (used for basename) OR direct json file path
    Output: base-code/input.ets
    """
    # Check if JSON file was specified directly
    input_p = Path(input_path)
    if input_p.suffix == '.json' and input_p.exists():
        json_path = input_p
        basename = json_path.stem
        print(f"  Step 2: Using specified JSON: {json_path}")
    else:
        basename = input_p.stem
        json_path = Path(output_base) / "json" / f"{basename}.json"
        if not json_path.exists():
            print(f"  ✗ Error: Step 1 output not found: {json_path}")
            print(f"     Run: pipeline_swift.py {input_path} -o {output_base} --step 1")
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
    
    generator = SwiftArkTSGenerator("mappings/components.json")
    base_code = generator.generate(ui_data)
    
    # Save base code
    base_path.parent.mkdir(parents=True, exist_ok=True)
    with open(base_path, 'w', encoding='utf-8') as f:
        f.write(base_code)
    print(f"    Saved: {base_path}")
    return base_code


def step3_llm(input_path: str, output_base: str, provider: str, skip_existing: bool = True) -> Optional[str]:
    """Step 3: Base code → LLM output
    Input: input.swift OR direct base-code file path
    Needs: json/input.json + base-code (inferred or specified)
    Output: {provider}/input.ets
    """
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
        print(f"  ✗ Error: JSON not found: {json_path}")
        return None
    if not base_path.exists():
        print(f"  ✗ Error: Base code not found: {base_path}")
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
        print(f"    ✗ Failed: Empty output from LLM")
        return None
    
    llm_path.parent.mkdir(parents=True, exist_ok=True)
    with open(llm_path, 'w', encoding='utf-8') as f:
        f.write(llm_code)
    print(f"    Saved: {llm_path}")
    return llm_code


def step4_post_fix(input_path: str, output_base: str, provider: str, skip_existing: bool = True) -> Optional[str]:
    """Step 4: LLM output → Post-fixed output
    Input: input.swift OR direct LLM output file path
    Output: {provider}-post/input.ets
    """
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
            print(f"  ✗ Error: Step 3 output not found: {llm_path}")
            return None
    
    print(f"  Step 4: Post-fix...")
    with open(llm_path, 'r', encoding='utf-8') as f:
        llm_code = f.read()
    
    fixed_code = post_fix(llm_code)
    
    if not fixed_code or len(fixed_code.strip()) < 50:
        print(f"    ✗ Failed: Post-fix produced empty output")
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
    """Process single Swift file with organized step-by-step outputs"""
    basename = Path(input_path).stem
    
    post_path = Path(output_base) / f"{provider}-post" / f"{basename}.ets"
    if skip_existing and is_valid_file(post_path) and step is None:
        print(f"[Skip] {basename}.swift [{provider}] - final output exists")
        return True
    
    try:
        print(f"\n[Processing] {basename}.swift [{provider}]" + (f" [Step {step}]" if step else " [All steps]"))
        
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
        
        # Full pipeline
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

        print(f"  ✓ Done: {basename}")
        return True

    except Exception as e:
        print(f"  ✗ Error: {e}")
        import traceback
        traceback.print_exc()
        return False


def iterate_all(nodes: List[Dict]):
    """Iterate all components"""
    for node in nodes:
        yield node
        yield from iterate_all(node.get("children", []))


def main():
    parser = argparse.ArgumentParser(
        description="SwiftUI to ArkTS - Step-by-step pipeline",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Examples:
  # Full pipeline
  python pipeline_swift.py suc/swift/001.swift -o output
  
  # Step by step
  python pipeline_swift.py suc/swift/001.swift -o output --step 1
  python pipeline_swift.py suc/swift/001.swift -o output --step 2
  python pipeline_swift.py suc/swift/001.swift -o output --step 3 --provider gpt
  python pipeline_swift.py suc/swift/001.swift -o output --step 4 --provider gpt
  
  # Use specific provider
  python pipeline_swift.py suc/swift/001.swift -o output --provider kimi-turbo
  
  # Process directory
  python pipeline_swift.py suc/swift -o output --provider gpt
        """
    )
    parser.add_argument("input", help="Input Swift file or directory")
    parser.add_argument("-o", "--output", required=True, help="Output base directory")
    parser.add_argument("--step", type=int, choices=[1, 2, 3, 4], help="Run single step only")
    parser.add_argument("--provider", default="gpt", help="Model provider (gpt, gpt-4o, deepseek, kimi-turbo, claude, glm)")
    parser.add_argument("--force", action="store_true", help="Overwrite existing files")
    
    args = parser.parse_args()
    
    skip_existing = not args.force
    
    if os.path.isdir(args.input):
        # Process directory
        swift_files = sorted([f for f in os.listdir(args.input) if f.endswith('.swift')])
        print(f"Found {len(swift_files)} Swift files in {args.input}")
        
        success = 0
        for swift_file in swift_files:
            input_path = os.path.join(args.input, swift_file)
            if process_file(input_path, args.output, args.provider, skip_existing, args.step):
                success += 1
        
        print(f"\n{'='*50}")
        print(f"Completed: {success}/{len(swift_files)} files")
    else:
        # Process single file
        process_file(args.input, args.output, args.provider, skip_existing, args.step)


if __name__ == "__main__":
    main()

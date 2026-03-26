#!/usr/bin/env python3
"""Post-fix ArkTS code from SwiftUI migration with modular control."""

import argparse
import re
import sys
from pathlib import Path

def post_fix(code: str, enable_constant_inlining=True, enable_lexical=True,
             enable_layout=True, enable_structural=True) -> str:
    """Apply deterministic fixes to ArkTS code generated from SwiftUI."""
    # Constant Inlining
    if enable_constant_inlining:
        code = _constant_inlining(code)

    # Lexical Rectification
    if enable_lexical:
        code = _lexical_rectification(code)

    # Layout Property Rectification
    if enable_layout:
        code = _layout_rectification(code)

    # Structural Integrity Validation
    if enable_structural:
        code = _structural_validation(code)

    return code


def _constant_inlining(code: str) -> str:
    """Inline constant references and remove unused class definitions."""
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
    return code


def _lexical_rectification(code: str) -> str:
    """Fix lexical errors from SwiftUI migration."""

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

    return code


def _layout_rectification(code: str) -> str:
    """Expand Swift-style padding arrays to ArkUI format."""
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
    return code


def _structural_validation(code: str) -> str:
    """Fix Blank placement and balance braces."""
    def fix_blank_in_illegal_container(code: str) -> str:
        lines = code.split('\n')
        result = []
        containers = []
        brace_level = 0
        legal_containers = {'Row', 'Column'}
        all_containers = ['Stack', 'Column', 'Row', 'Grid', 'List']

        for line in lines:
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


def process_directory(input_dir: Path, output_dir: Path, enable_flags: dict):
    """Recursively process all .ets files in input_dir."""
    input_dir = Path(input_dir).resolve()
    output_dir = Path(output_dir).resolve()
    output_dir.mkdir(parents=True, exist_ok=True)

    ets_files = list(input_dir.rglob('*.ets'))
    if not ets_files:
        print(f"No .ets files found in {input_dir}")
        return

    print(f"Found {len(ets_files)} .ets files.")
    for src in ets_files:
        rel_path = src.relative_to(input_dir)
        dst = output_dir / rel_path
        dst.parent.mkdir(parents=True, exist_ok=True)

        try:
            with open(src, 'r', encoding='utf-8') as f:
                original = f.read()

            fixed = post_fix(original,
                             enable_constant_inlining=enable_flags['const'],
                             enable_lexical=enable_flags['lexical'],
                             enable_layout=enable_flags['layout'],
                             enable_structural=enable_flags['structural'])

            with open(dst, 'w', encoding='utf-8') as f:
                f.write(fixed)

            print(f"Processed: {src} -> {dst}")
        except Exception as e:
            print(f"Error processing {src}: {e}")


def main():
    parser = argparse.ArgumentParser(
        description="Post-fix ArkTS files (generated from SwiftUI) with modular control.",
        epilog="""
Examples:
  # Process all .ets files in input/ with all modules enabled
  python post_fix_swift_ets.py input/ output/

  # Disable constant inlining for ablation
  python post_fix_swift_ets.py input/ output/ --disable-const

  # Disable multiple modules
  python post_fix_swift_ets.py input/ output/ --disable-lexical --disable-layout
        """
    )
    parser.add_argument("input_dir", help="Directory containing .ets files")
    parser.add_argument("output_dir", help="Directory to write fixed .ets files")
    parser.add_argument("--disable-const", action="store_true", help="Disable constant inlining")
    parser.add_argument("--disable-lexical", action="store_true", help="Disable lexical rectification")
    parser.add_argument("--disable-layout", action="store_true", help="Disable layout property rectification")
    parser.add_argument("--disable-structural", action="store_true", help="Disable structural integrity validation")

    args = parser.parse_args()

    enable_flags = {
        'const': not args.disable_const,
        'lexical': not args.disable_lexical,
        'layout': not args.disable_layout,
        'structural': not args.disable_structural,
    }

    if not any(enable_flags.values()):
        print("Error: All modules are disabled. Nothing to do.")
        sys.exit(1)

    print("Enabled modules:")
    for name, enabled in enable_flags.items():
        print(f"  {name}: {'yes' if enabled else 'no'}")

    process_directory(Path(args.input_dir), Path(args.output_dir), enable_flags)


if __name__ == "__main__":
    main()
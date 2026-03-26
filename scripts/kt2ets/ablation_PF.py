#!/usr/bin/env python3
"""Post-fix ArkTS code with modular control for ablation study."""

import argparse
import re
import sys
from pathlib import Path


def post_fix(code: str, enable_constant_inlining=True, enable_lexical=True,
             enable_layout=True, enable_structural=True) -> str:
    """Apply deterministic fixes to ArkTS code."""
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

    return code


def _layout_rectification(code: str) -> str:
    def expand_padding(match):
        prop, content = match.group(1), match.group(2)
        h = re.search(r'horizontal\s*:\s*(\d+)', content)
        v = re.search(r'vertical\s*:\s*(\d+)', content)
        h_val, v_val = (h.group(1) if h else None), (v.group(1) if v else None)

        if h_val and v_val and h_val == v_val:
            return f'.{prop}({h_val})'
        parts = []
        if h_val:
            parts.extend([f'left: {h_val}', f'right: {h_val}'])
        if v_val:
            parts.extend([f'top: {v_val}', f'bottom: {v_val}'])
        return f'.{prop}({{{", ".join(parts)}}})' if parts else match.group(0)

    code = re.sub(r'\.(padding|margin)\(\s*\{([^}]*(?:horizontal|vertical)[^}]*)\}\s*\)', expand_padding, code)
    return code


def _structural_validation(code: str) -> str:
    def fix_blank_in_illegal_container(code):
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


def process_directory(input_dir: Path, output_dir: Path, enable_flags: dict):
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
    parser = argparse.ArgumentParser(description="Post-fix ArkTS files with modular control.")
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

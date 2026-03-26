#!/usr/bin/env python3
"""ArkTS Code Generator for SwiftUI"""

import json
import os
import re
from typing import Dict, List, Any, Optional


class SwiftArkTSGenerator:
    """SwiftUI to ArkTS code generator with LLM metadata"""

    def __init__(self, mapping_file: Optional[str] = None):
        self.mappings: Dict = {}
        self.theme: Dict = {}
        self.theme_colors: Dict[str, str] = {}
        self.indent_str = "  "

        if mapping_file and os.path.exists(mapping_file):
            with open(mapping_file, 'r', encoding='utf-8') as f:
                self.mappings = json.load(f)

    def load_json(self, json_path: str) -> Dict:
        """Load JSON file"""
        with open(json_path, 'r', encoding='utf-8') as f:
            return json.load(f)

    def generate(self, ui_data: Dict) -> str:
        """Generate complete ArkTS code"""
        self.theme = ui_data.get("theme", {})
        self.theme_colors = self.theme.get("colors", {})

        ui_structure = ui_data.get("ui_structure", [])
        ui_lines = []
        for node in ui_structure:
            code = self._generate_node(node, level=2)
            if code:
                ui_lines.append(code)
        ui_code = "\n".join(ui_lines)

        return self._assemble_code(ui_code)

    def _get_component_config(self, comp: str) -> Optional[Dict]:
        """Get component configuration with inheritance support"""
        config = self.mappings.get(comp)
        if not config:
            return None

        if "inherits" in config:
            base_name = config["inherits"]
            base_config = self._get_component_config(base_name) or self.mappings.get(base_name, {}).copy()
            if base_config:
                merged = self._deep_merge(base_config, config)
                return merged
        return config

    def _deep_merge(self, base: Dict, override: Dict) -> Dict:
        """Deep merge two dictionaries"""
        result = base.copy()
        for key, value in override.items():
            if key == "inherits":
                continue
            if isinstance(value, dict) and key in result and isinstance(result[key], dict):
                result[key] = self._deep_merge(result[key], value)
            else:
                result[key] = value
        return result

    def _generate_llm_metadata(self, node: Dict, level: int, config: Optional[Dict]) -> List[str]:
        """Generate LLM metadata comments"""
        indent = self.indent_str * level
        comp = node.get("component", "")
        props = node.get("props", {})
        modifiers = node.get("modifiers", [])
        children = node.get("children", [])
        
        lines = []
        lines.append(f"{indent}// === {comp} ===")
        
        if props:
            filtered = {}
            for k, v in props.items():
                val_str = str(v)
                if len(val_str) > 100:
                    filtered[k] = val_str[:97] + "..."
                else:
                    filtered[k] = v
            
            if filtered:
                props_json = json.dumps(filtered, ensure_ascii=False, separators=(',', ':'))
                if len(props_json) > 200:
                    props_json = props_json[:197] + "..."
                lines.append(f"{indent}// props: {props_json}")
        
        if modifiers:
            mod_list = []
            for mod in modifiers:
                mod_raw = mod.get("raw", "")
                mod_clean = mod_raw.replace('\n', ' ')
                if len(mod_clean) > 80:
                    mod_clean = mod_clean[:77] + "..."
                mod_list.append(mod_clean)
            
            if mod_list:
                mod_json = json.dumps(mod_list, ensure_ascii=False, separators=(',', ':'))
                if len(mod_json) > 200:
                    mod_json = mod_json[:197] + "..."
                lines.append(f"{indent}// modifiers: {mod_json}")
        
        if children:
            lines.append(f"{indent}// children: {len(children)}")
        
        return lines

    def _generate_node(self, node: Dict, level: int = 0) -> str:
        """Recursively generate a single node with LLM comments"""
        comp = node.get("component", "")
        if not comp:
            return ""
            
        props = node.get("props", {})
        modifiers = node.get("modifiers", [])
        children = node.get("children", [])

        indent = self.indent_str * level

        config = self._get_component_config(comp)

        metadata_lines = self._generate_llm_metadata(node, level, config)
        metadata_block = "\n".join(metadata_lines)

        children_code = ""
        if children:
            child_lines = [self._generate_node(child, level + 1) for child in children]
            children_code = "\n".join(line for line in child_lines if line)

        component_code = self._generate_component(comp, node, children_code, indent, config)

        return f"{metadata_block}\n{component_code}"

    def _generate_component(self, comp: str, node: Dict, children_code: str, indent: str, config: Optional[Dict]) -> str:
        """Generate component code"""
        props = node.get("props", {})
        modifiers = node.get("modifiers", [])

        if not config:
            return self._generate_generic(comp, children_code, indent)

        arkts_comp = config.get("arkts_component", comp)

        if not children_code and "template_empty" in config:
            template = config["template_empty"]
        elif children_code and "template_with_children" in config:
            template = config["template_with_children"]
        elif "template_with_label" in config and props.get("text") and not children_code:
            template = config["template_with_label"]
        else:
            template = config.get("template", "{indent}{component}(){chain}")

        vars_dict = {"indent": indent, "component": arkts_comp}

        props_mapping = config.get("props_mapping", {})
        for prop_key, prop_value in props.items():
            if prop_key in props_mapping:
                mapping = props_mapping[prop_key]
                self._apply_prop_mapping(prop_key, prop_value, mapping, vars_dict)
            elif prop_key == "text":
                vars_dict["text"] = repr(prop_value) if isinstance(prop_value, str) else prop_value

        if children_code:
            vars_dict["content"] = f"\n{children_code}"
            vars_dict["children"] = children_code
        else:
            vars_dict["content"] = ""
            vars_dict["children"] = ""

        chain = self._generate_modifier_chain(modifiers, config)
        
        if "align_chain" in vars_dict:
            chain = "".join(vars_dict["align_chain"]) + chain
        
        vars_dict["chain"] = chain

        default_props = config.get("default_props", {})
        for key, value in default_props.items():
            if key not in vars_dict:
                vars_dict[key] = value

        try:
            return template.format(**vars_dict)
        except KeyError:
            return self._generate_generic(arkts_comp, children_code, indent)

    def _apply_prop_mapping(self, prop_key: str, prop_value: Any, mapping: Dict, vars_dict: Dict):
        """Apply property mapping"""
        mapping_type = mapping.get("type", "param")

        if mapping_type == "ignore":
            return

        elif mapping_type == "param":
            param_name = mapping.get("param_name", prop_key)
            vars_dict[param_name] = prop_value

        elif mapping_type == "param_state":
            param_name = mapping.get("param_name", prop_key)
            default = mapping.get("default", f"this.{prop_key}")
            vars_dict[param_name] = default

        elif mapping_type == "content":
            if isinstance(prop_value, str):
                vars_dict["text"] = repr(prop_value)
            else:
                vars_dict["text"] = prop_value

        elif mapping_type == "alignment":
            align_map = mapping.get("mapping", {})
            chain_method = mapping.get("chain_method", "alignItems")
            arkts_align = None
            
            if isinstance(prop_value, str):
                for swift_align, align_val in align_map.items():
                    if swift_align in prop_value:
                        arkts_align = align_val
                        break
            
            if not arkts_align:
                arkts_align = mapping.get("default", "Alignment.Center")
            
            if "align_chain" not in vars_dict:
                vars_dict["align_chain"] = []
            vars_dict["align_chain"].append(f".{chain_method}({arkts_align})")

        elif mapping_type == "space":
            if isinstance(prop_value, (int, float)):
                vars_dict["space"] = prop_value
            elif isinstance(prop_value, str):
                match = re.search(r'(\d+)', prop_value)
                if match:
                    vars_dict["space"] = int(match.group(1))
                else:
                    vars_dict["space"] = mapping.get("default", 0)
            else:
                vars_dict["space"] = mapping.get("default", 0)

    def _generate_modifier_chain(self, modifiers: List[Dict], config: Dict) -> str:
        """Generate modifier chain"""
        if not modifiers:
            return ""

        simple_mappings = {
            "padding": "padding",
            "background": "backgroundColor", 
            "foregroundColor": "fontColor",
            "font": "fontSize",
            "frame": "frame",
            "cornerRadius": "borderRadius",
            "shadow": "shadow",
            "lineLimit": "maxLines",
            "fill": "fill",
            "stroke": "stroke",
            "resizable": "objectFit",
        }

        chain_parts = []
        for mod in modifiers:
            mod_name = mod.get("name", "")
            mod_raw = mod.get("raw", "")
            
            value = self._extract_modifier_value(mod_raw)
            resolved_value = self._resolve_value(value) if value else ""
            arkts_name = simple_mappings.get(mod_name, mod_name)
            
            if mod_name == "resizable":
                chain_parts.append(f".{arkts_name}(ImageFit.Contain)")
            elif resolved_value and resolved_value != value:
                chain_parts.append(f".{arkts_name}({resolved_value})")
            elif value:
                chain_parts.append(f".{arkts_name}({value})")
            else:
                chain_parts.append(f".{arkts_name}()")

        return "".join(chain_parts)

    def _extract_modifier_value(self, mod_raw: str) -> str:
        """Extract parameter value from Swift modifier"""
        match = re.match(r'\w+\((.*)\)', mod_raw)
        if match:
            return match.group(1)
        return ""

    def _resolve_value(self, value: str) -> str:
        """Resolve token references in value"""
        if not isinstance(value, str):
            return str(value)

        # Resolve color references
            patterns = [
                rf'AppTokens\.Colors\.{color_name}\b',
                rf'AppTokens\.Color\.{color_name}\b',
                rf'Colors\.{color_name}\b',
                rf'Color\.{color_name}\b',
            ]
            for pattern in patterns:
                value = re.sub(pattern, hex_val, value)
        
        # Resolve font references
        typography_patterns = [
            r'AppTokens\.Typography(?:Tokens)?\.(\w+)',
            r'Typography(?:Tokens)?\.(\w+)',
        ]
        for pattern in typography_patterns:
            for match in re.finditer(pattern, value):
                font_key = match.group(1)
                font_val = self.theme.get("fonts", {}).get(font_key, "")
                if font_val:
                    size_match = re.search(r'size:\s*(\d+)', str(font_val))
                    if size_match:
                        value = value.replace(match.group(0), size_match.group(1))
        
        # Resolve spacing references
        spacing_map = {
            'xs': 2, 'sm': 4, 'md': 8, 'lg': 12, 'xl': 16,
            'xxl': 24, 'xxxl': 32, 'zero': 0
        }
        spacing_patterns = [
            r'AppTokens\.Spacing\.(\w+)',
            r'Spacing\.(\w+)',
        ]
        for pattern in spacing_patterns:
            for match in re.finditer(pattern, value):
                spacing_key = match.group(1)
                spacing_val = self.theme.get("spacing", {}).get(spacing_key)
                if spacing_val:
                    num_match = re.search(r'(\d+)', str(spacing_val))
                    if num_match:
                        value = value.replace(match.group(0), num_match.group(1))
                elif spacing_key in spacing_map:
                    value = value.replace(match.group(0), str(spacing_map[spacing_key]))
        
        # Resolve shape references
        shape_patterns = [
            r'AppTokens\.Shapes\.(\w+)',
            r'Shapes\.(\w+)',
        ]
        for pattern in shape_patterns:
            for match in re.finditer(pattern, value):
                shape_key = match.group(1)
                shape_val = self.theme.get("shapes", {}).get(shape_key)
                if shape_val:
                    num_match = re.search(r'(\d+)', str(shape_val))
                    if num_match:
                        value = value.replace(match.group(0), num_match.group(1))

        return value

    def _convert_swift_modifier(self, mod_name: str, mod_raw: str) -> Optional[str]:
        """Convert Swift modifier to ArkTS"""
        common_mappings = {
            "font": ".fontSize",
            "foregroundColor": ".fontColor",
            "background": ".backgroundColor",
            "padding": ".padding",
            "frame": ".frame",
            "cornerRadius": ".borderRadius",
            "shadow": ".shadow",
            "lineLimit": ".maxLines",
            "resizable": ".objectFit(ImageFit.Contain)",
            "fill": ".fill",
            "stroke": ".stroke",
            "clipShape": "",
            "buttonStyle": "",
            "ignoresSafeArea": "",
            "navigationBarHidden": "",
        }

        if mod_name in common_mappings:
            arkts_name = common_mappings[mod_name]
            if arkts_name == "":
                return None

            value = self._extract_modifier_value(mod_raw)
            value = self._resolve_value(value)

            if value:
                return f"{arkts_name}({value})"
            else:
                return arkts_name

        return None

    def _generate_generic(self, comp: str, children_code: str, indent: str) -> str:
        """Generic component generation"""
        if children_code:
            return f"{indent}{comp}() {{\n{children_code}\n{indent}}}"
        return f"{indent}{comp}()"

    def _assemble_code(self, ui_code: str) -> str:
        """Assemble complete ArkTS code"""
        return f"""@Entry
@Component
struct Index {{
  build() {{
    Stack() {{
{ui_code}
    }}.width('100%').height('100%')
  }}
}}"""


def main():
    import argparse
    parser = argparse.ArgumentParser(description="Generate ArkTS from SwiftUI JSON with LLM metadata")
    parser.add_argument("input", help="Input JSON file")
    parser.add_argument("-m", "--mapping", default="mappings/components.json")
    parser.add_argument("-o", "--output")
    args = parser.parse_args()

    mapping_path = args.mapping
    if not os.path.exists(mapping_path):
        script_dir = os.path.dirname(os.path.abspath(__file__))
        mapping_path = os.path.join(script_dir, mapping_path)

    generator = SwiftArkTSGenerator(mapping_path)
    ui_data = generator.load_json(args.input)
    code = generator.generate(ui_data)

    if args.output:
        with open(args.output, 'w', encoding='utf-8') as f:
            f.write(code)
        print(f"[swift generator] {args.input} -> {args.output}")
    else:
        print(code)


if __name__ == "__main__":
    main()

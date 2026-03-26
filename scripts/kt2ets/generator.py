#!/usr/bin/env python3
"""ArkTS Skeleton Generator - Generates ArkTS with embedded JSON metadata."""

import json
import os
import re
from typing import Dict, List, Any, Optional
from dataclasses import dataclass


@dataclass
class StateVariable:
    name: str
    type: str
    default_value: str


class ArkTSGeneratorV3:
    def __init__(self, mapping_file: Optional[str] = None):
        self.mappings: Dict = {}
        self.state_vars: Dict[str, StateVariable] = {}
        self.indent_str = "  "
        self.theme: Dict = {}
        self.theme_colors: Dict[str, str] = {}
        self.state_config: Dict = {}

        if mapping_file and os.path.exists(mapping_file):
            with open(mapping_file, 'r', encoding='utf-8') as f:
                self.mappings = json.load(f)
                self.state_config = self.mappings.get("_state_variables", {})

    def load_json(self, json_path: str) -> Dict:
        with open(json_path, 'r', encoding='utf-8') as f:
            return json.load(f)

    def generate(self, ui_data: Dict) -> str:
        self.state_vars = {}
        self.theme = ui_data.get("theme", {})
        self.theme_colors = self.theme.get("colors", {})

        parsed_state_vars = ui_data.get("state_variables", {})
        for var_name, var_info in parsed_state_vars.items():
            self.state_vars[var_name] = StateVariable(
                name=var_name,
                type=var_info.get("type", "any"),
                default_value=self._convert_initial_value(var_info.get("initial_value", ""), var_info.get("type", "any"))
            )

        ui_structure = ui_data.get("ui_structure", [])
        self._collect_state_variables_recursive(ui_structure)

        ui_lines = []
        for node in ui_structure:
            code = self._generate_node_with_metadata(node, level=2)
            if code:
                ui_lines.append(code)
        ui_code = "\n".join(ui_lines)

        return self._assemble_code(ui_code)

    def _convert_initial_value(self, value: str, var_type: str) -> str:
        value = value.strip()
        
        if var_type == "string":
            return value
        
        if var_type == "boolean":
            return value.lower()
        
        if var_type == "number":
            return value
        
        if var_type == "array":
            return value
        
        if value.startswith("Color("):
            match = re.search(r'0xFF([0-9A-Fa-f]{6})', value)
            if match:
                return f"'#{match.group(1)}'"
            return "'#000000'"
        
        if value:
            return value
        return "0"

    def _collect_state_variables_recursive(self, nodes: List[Dict]):
        for node in nodes:
            self._extract_state_from_node(node)
            self._collect_state_variables_recursive(node.get("children", []))

    def _extract_state_from_node(self, node: Dict):
        props = node.get("props", {})
        comp = node["component"]

        for key, value in props.items():
            if isinstance(value, str):
                if value in ["fontSize", "syncProgress", "progress", "isOn", "checked", "text"]:
                    if value not in self.state_vars:
                        self.state_vars[value] = StateVariable(
                            name=value,
                            type=self._infer_type_from_context(key, comp),
                            default_value=self._get_default_value(key, comp)
                        )

            if isinstance(value, dict):
                if value.get("_type") == "template":
                    var_name = self._extract_variable_from_template(value["value"])
                    if var_name and var_name not in self.state_vars:
                        default_val = "0"
                        if comp in self.state_config:
                            default_val = self.state_config[comp].get("default", "0")
                        self.state_vars[var_name] = StateVariable(
                            name=var_name,
                            type="number",
                            default_value=default_val
                        )

        if comp in self.state_config:
            cfg = self.state_config[comp]
            var_name = cfg.get("var_name")
            if var_name and var_name not in self.state_vars:
                self.state_vars[var_name] = StateVariable(
                    name=var_name,
                    type=cfg.get("type", "any"),
                    default_value=cfg.get("default", "0")
                )

    def _extract_variable_from_template(self, template: str) -> Optional[str]:
        match = re.search(r'\$\{(\w+)', template)
        if match:
            return match.group(1)
        match = re.search(r'\$(\w+)', template)
        if match:
            return match.group(1)
        return None

    def _infer_type_from_context(self, prop_name: str, component: str) -> str:
        type_hints = {
            "fontSize": "number", "progress": "number", "value": "number",
            "isOn": "boolean", "checked": "boolean", "select": "boolean",
            "text": "string", "color": "string",
        }
        return type_hints.get(prop_name, "any")

    def _get_default_value(self, prop_name: str, component: str) -> str:
        defaults = {
            ("fontSize", "Slider"): "24",
            ("progress", "LinearProgressIndicator"): "0.3",
            ("progress", "Progress"): "30",
        }
        return defaults.get((prop_name, component), "0")

    def _generate_node_with_metadata(self, node: Dict, level: int = 0) -> str:
        comp = node["component"]
        props = node.get("props", {})
        modifier = node.get("modifier", {})
        children = node.get("children", [])

        indent = self.indent_str * level

        metadata_lines = []
        metadata_lines.append(f"{indent}// === {comp} ===")
        
        if props:
            metadata_lines.append(f"{indent}// props: {json.dumps(props, ensure_ascii=False)}")
        
        if modifier:
            metadata_lines.append(f"{indent}// modifier: {json.dumps(modifier, ensure_ascii=False)}")
        
        if children:
            metadata_lines.append(f"{indent}// children: {len(children)}")

        metadata_block = "\n".join(metadata_lines)

        children_code = ""
        if children:
            child_lines = [self._generate_node_with_metadata(child, level + 1) for child in children]
            children_code = "\n".join(line for line in child_lines if line)

        component_code = self._generate_component_with_fallback(comp, node, children_code, indent, level)

        return f"{metadata_block}\n{component_code}"

    def _generate_component_with_fallback(self, comp: str, node: Dict, children_code: str, indent: str, level: int) -> str:
        config = self._get_component_config(comp)
        
        if not config:
            return self._gen_Generic(comp, node, children_code, indent, level)
        
        return self._generate_from_config(comp, node, children_code, indent, config)

    def _get_component_config(self, comp: str) -> Optional[Dict]:
        config = self.mappings.get(comp)
        if not config:
            return None
        
        if "inherits" in config:
            base_name = config["inherits"]
            base_config = self._get_component_config(base_name) or self.mappings.get(base_name, {}).copy()
            if base_config:
                merged = self._deep_merge(base_config.copy(), config)
                return merged
        return config

    def _deep_merge(self, base: Dict, override: Dict) -> Dict:
        result = base.copy()
        for key, value in override.items():
            if key == "inherits":
                continue
            if isinstance(value, dict) and key in result and isinstance(result[key], dict):
                result[key] = self._deep_merge(result[key], value)
            else:
                result[key] = value
        return result

    def _generate_from_config(self, comp: str, node: Dict, children_code: str, indent: str, config: Dict) -> str:
        props = node.get("props", {})
        modifier = node.get("modifier", {})
        
        if not children_code and "template_empty" in config:
            template = config["template_empty"]
        elif children_code and "template_with_children" in config:
            template = config["template_with_children"]
        elif "template_with_label" in config and props.get("text") and not children_code:
            template = config["template_with_label"]
        else:
            template = config.get("template", "{indent}{component}() {{{content}\n{indent}}}")
        
        vars_dict = {"indent": indent, "component": comp}
        
        props_mapping = config.get("props_mapping", {})
        chain_parts = []
        
        for prop_key, prop_value in props.items():
            if prop_key in props_mapping:
                mapping = props_mapping[prop_key]
                self._apply_prop_mapping(prop_key, prop_value, mapping, vars_dict, chain_parts, node, config)
        
        modifier_mapping = config.get("modifier_mapping", {})
        for mod_key, mod_value in modifier.items():
            if mod_key in modifier_mapping:
                mapping = modifier_mapping[mod_key]
                self._apply_modifier_mapping(mod_key, mod_value, mapping, chain_parts)
        
        if children_code:
            vars_dict["content"] = f"\n{children_code}"
            vars_dict["children"] = children_code
        else:
            vars_dict["content"] = ""
            vars_dict["children"] = ""
        
        default_props = config.get("default_props", {})
        for key, value in default_props.items():
            if key not in vars_dict:
                vars_dict[key] = value
        
        if chain_parts:
            vars_dict["chain"] = "".join(chain_parts)
        elif "default_chain" in config:
            vars_dict["chain"] = config["default_chain"]
        else:
            vars_dict["chain"] = ""
        
        try:
            result = template.format(**vars_dict)
            return result
        except KeyError:
            return self._fallback_generate(config, node, children_code, indent)

    def _apply_prop_mapping(self, prop_key: str, prop_value: Any, mapping: Dict, vars_dict: Dict, chain_parts: List[str], node: Dict, config: Dict):
        mapping_type = mapping.get("type", "param")
        
        if mapping_type == "ignore":
            return
        
        elif mapping_type == "param":
            param_name = mapping.get("param_name", prop_key)
            vars_dict[param_name] = self._transform_value(prop_value, mapping)
        
        elif mapping_type == "param_state":
            param_name = mapping.get("param_name", prop_key)
            default = mapping.get("default", f"this.{prop_key}")
            
            if isinstance(prop_value, str):
                if prop_value in self.state_vars:
                    vars_dict[param_name] = f"this.{prop_value}"
                else:
                    vars_dict[param_name] = prop_value
            elif isinstance(prop_value, dict):
                val_str = prop_value.get("value", "")
                match = re.search(r'\{(\w+)', val_str)
                if match:
                    vars_dict[param_name] = f"this.{match.group(1)}"
                else:
                    vars_dict[param_name] = default
            else:
                vars_dict[param_name] = default
        
        elif mapping_type == "content":
            if isinstance(prop_value, dict):
                prop_value = prop_value.get("value", "")
            if mapping.get("escape_quotes"):
                prop_value = str(prop_value).replace("'", "\\'")
            vars_dict["text"] = prop_value
        
        elif mapping_type == "chain":
            chain_method = mapping.get("chain_method", prop_key)
            value = self._transform_value(prop_value, mapping)
            chain_parts.append(f".{chain_method}({value})")
        
        elif mapping_type == "chain_append":
            chain_parts.append(mapping.get("chain_value", ""))
        
        elif mapping_type == "alignment":
            chain_method = mapping.get("chain_method", "alignItems")
            align_map = mapping.get("mapping", {})
            
            align_str = str(prop_value)
            matched = False
            for kotlin_align, arkts_align in align_map.items():
                if kotlin_align in align_str:
                    chain_parts.append(f".{chain_method}({arkts_align})")
                    matched = True
                    break
            
            if not matched and "Center" in align_str:
                default_align = "HorizontalAlign.Center" if "Horizontal" in chain_method else "VerticalAlign.Center"
                chain_parts.append(f".{chain_method}({default_align})")
        
        elif mapping_type == "space":
            if isinstance(prop_value, dict):
                if prop_value.get("type") == "spacedBy":
                    vars_dict["space"] = prop_value.get("value", 0)
                else:
                    vars_dict["space"] = 0
            elif isinstance(prop_value, str):
                match = re.search(r'(\d+(?:\.\d+)?)', prop_value)
                if match:
                    vars_dict["space"] = int(float(match.group(1)))
                else:
                    vars_dict["space"] = 0
            elif isinstance(prop_value, (int, float)):
                vars_dict["space"] = prop_value
            else:
                vars_dict["space"] = 0
        
        elif mapping_type == "range":
            if isinstance(prop_value, str) and ".." in prop_value:
                parts = prop_value.replace("f", "").split("..")
                try:
                    vars_dict["min"] = int(float(parts[0]))
                    vars_dict["max"] = int(float(parts[1]))
                except:
                    vars_dict["min"] = mapping.get("default_min", 16)
                    vars_dict["max"] = mapping.get("default_max", 48)
            else:
                vars_dict["min"] = mapping.get("default_min", 16)
                vars_dict["max"] = mapping.get("default_max", 48)
        
        elif mapping_type == "src":
            default_src = "$r('app.media.icon')"
            if isinstance(prop_value, str) and "painterResource" in prop_value:
                match = re.search(r'R\.(\w+)\.(\w+)', prop_value)
                if match:
                    vars_dict["src"] = f"$r('app.media.{match.group(2)}')"
                else:
                    vars_dict["src"] = default_src
            else:
                vars_dict["src"] = default_src

    def _apply_modifier_mapping(self, mod_key: str, mod_value: Any, mapping: Any, chain_parts: List[str]):
        if isinstance(mapping, str):
            if "{value}" in mapping:
                value = self._resolve_tokens_in_value(mod_value)
                chain_parts.append(mapping.format(value=value))
            else:
                chain_parts.append(mapping)
        elif isinstance(mapping, dict):
            chain_method = mapping.get("chain_method", mod_key)
            value = self._resolve_tokens_in_value(mod_value)
            if mapping.get("strip_unit") == ".dp" and isinstance(value, str):
                value = value.replace(".dp", "")
            chain_parts.append(f".{chain_method}({value})")

    def _resolve_tokens_in_value(self, value: Any) -> Any:
        if isinstance(value, dict):
            return {k: self._resolve_tokens_in_value(v) for k, v in value.items()}
        elif isinstance(value, list):
            return [self._resolve_tokens_in_value(v) for v in value]
        elif isinstance(value, str):
            value = value.replace(".dp", "").replace(".sp", "")
            if value in self.theme_colors:
                return self.theme_colors[value]
            if "Spacing." in value:
                token_name = value.split("Spacing.")[-1].strip()
                if token_name in self.theme.get("spacing", {}):
                    return self.theme["spacing"][token_name]
            if "Colors." in value:
                token_name = value.split("Colors.")[-1].strip()
                if token_name in self.theme_colors:
                    return self.theme_colors[token_name]
        return value

    def _transform_value(self, value: Any, mapping: Dict) -> Any:
        if isinstance(value, dict):
            if "_values" in value:
                value = value["_values"][0]
            elif "_value" in value:
                value = value["_value"]
        
        if isinstance(value, str):
            if value in self.theme_colors:
                value = self.theme_colors[value]
        
        return value

    def _fallback_generate(self, config: Dict, node: Dict, children_code: str, indent: str) -> str:
        arkts_comp = config.get("arkts_component", node["component"])
        if children_code:
            return f"{indent}{arkts_comp}() {{\n{children_code}\n{indent}}}"
        return f"{indent}{arkts_comp}()"

    def _gen_Generic(self, comp: str, node: Dict, children_code: str, indent: str, level: int) -> str:
        code = f"{indent}{comp}() {{"
        if children_code:
            code += f"\n{children_code}"
        code += f"\n{indent}}}"
        return code

    def _assemble_code(self, ui_code: str) -> str:
        state_lines = []
        for name, state in self.state_vars.items():
            state_lines.append(f"  @State {name}: {state.type} = {state.default_value}")

        state_section = "\n".join(state_lines)

        return f"""@Entry
@Component
struct Index {{{state_section}
  build() {{
    Stack() {{
{ui_code}
    }}.width('100%').height('100%')
  }}
}}"""


def main():
    import argparse
    parser = argparse.ArgumentParser(description="Generate ArkTS from JSON (v3 - Rich Metadata)")
    parser.add_argument("input", help="Input JSON file")
    parser.add_argument("-m", "--mapping", default="mappings/components.json")
    parser.add_argument("-o", "--output")
    args = parser.parse_args()

    mapping_path = args.mapping
    if not os.path.exists(mapping_path):
        script_dir = os.path.dirname(os.path.abspath(__file__))
        mapping_path = os.path.join(script_dir, mapping_path)

    generator = ArkTSGeneratorV3(mapping_path)
    ui_data = generator.load_json(args.input)
    code = generator.generate(ui_data)

    if args.output:
        with open(args.output, 'w', encoding='utf-8') as f:
            f.write(code)
        print(f"[generator v3] {args.input} -> {args.output}")
    else:
        print(code)


if __name__ == "__main__":
    main()

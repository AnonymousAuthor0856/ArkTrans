#!/usr/bin/env python3
"""Kotlin Compose UI Parser - Convert Kotlin UI to hierarchical JSON tree."""

import os
import json
import re
import sys
from typing import List, Dict, Any, Optional, Tuple
from dataclasses import dataclass, field
from tree_sitter import Language, Parser
import tree_sitter_kotlin as tskotlin


@dataclass
class UINode:
    component: str
    props: Dict[str, Any] = field(default_factory=dict)
    modifier: Dict[str, Any] = field(default_factory=dict)
    children: List['UINode'] = field(default_factory=list)
    source_range: Optional[Tuple[int, int]] = None

    def to_dict(self) -> Dict:
        result = {
            "component": self.component,
            "props": self.props,
            "modifier": self.modifier,
        }
        if self.children:
            result["children"] = [child.to_dict() for child in self.children]
        if self.source_range:
            result["source_range"] = self.source_range
        return result


class KotlinUIParser:
    BLACKLIST = {
        "remember", "mutableStateOf", "mutableStateListOf",
        "derivedStateOf", "produceState",
        "Color", "Color.Companion",
        "SideEffect", "LaunchedEffect", "DisposableEffect",
        "format", "stringResource", "dimensionResource",
        "LocalContext", "LocalDensity", "LocalLifecycleOwner",
    }

    WRAPPER_COMPONENTS = {
        "MaterialTheme", "AppTheme", "AppTokens",
        "Typography", "TextStyle", "Shapes", "ShadowSpec",
        "RoundedCornerShape", "CircleShape", "RectangleShape",
        "List", "PaddingValues", "WindowInsets",
        "BorderStroke", "Offset", "Dp", "DpRect",
        "Modifier",
    }

    COMPOSE_COMPONENTS = {
        "Column", "Row", "Box", "Stack", "ConstraintLayout",
        "LazyColumn", "LazyRow", "LazyVerticalGrid", "LazyHorizontalGrid",
        "Scaffold", "Surface", "Card",
        "Text", "Button", "OutlinedButton", "TextButton", "IconButton",
        "Icon", "Image", "Spacer", "Divider", "HorizontalDivider", "VerticalDivider",
        "Canvas",
        "TextField", "OutlinedTextField", "TextInput",
        "Slider", "ProgressBar", "LinearProgressIndicator", "CircularProgressIndicator",
        "Checkbox", "Switch", "RadioButton",
    }

    def __init__(self):
        self.language = Language(tskotlin.language())
        self.parser = Parser(self.language)
        self.source_bytes: bytes = b""
        self.source_str: str = ""
        self.theme_colors: Dict[str, str] = {}
        self.spacing_tokens: Dict[str, str] = {}
        self.typography_tokens: Dict[str, Dict] = {}
        self.custom_composables: Dict[str, Any] = {}
        self.data_classes: set = set()

    def get_text(self, node) -> str:
        if not node:
            return ""
        return self.source_bytes[node.start_byte:node.end_byte].decode('utf-8')

    def get_line_number(self, node) -> int:
        if not node:
            return 0
        return self.source_str[:node.start_byte].count('\n') + 1

    def is_component_name(self, name: str) -> bool:
        if not name or not name[0].isupper():
            return False
        if name in self.BLACKLIST:
            return False
        if name in self.data_classes:
            return False
        return True

    def split_arguments(self, arg_text: str) -> List[str]:
        args = []
        buf = []
        depth = 0
        in_string = False
        string_char = None

        for ch in arg_text:
            if ch in ('"', "'") and (not buf or buf[-1] != '\\'):
                if not in_string:
                    in_string = True
                    string_char = ch
                elif ch == string_char:
                    in_string = False
                    string_char = None

            if not in_string:
                if ch == ',' and depth == 0:
                    part = ''.join(buf).strip()
                    if part:
                        args.append(part)
                    buf = []
                    continue
                if ch in '([{':
                    depth += 1
                elif ch in ')]}':
                    depth = max(depth - 1, 0)

            buf.append(ch)

        last = ''.join(buf).strip()
        if last:
            args.append(last)

        return args

    def parse_argument_map(self, arg_text: str) -> Dict[str, Any]:
        arg_text = arg_text.strip()
        if not arg_text:
            return {}

        parts = self.split_arguments(arg_text)
        named = {}
        positional = []

        for part in parts:
            if '=' in part and not part.startswith('='):
                eq_pos = part.find('=')
                key = part[:eq_pos].strip()
                val = part[eq_pos + 1:].strip()
                named[key] = val
            else:
                positional.append(part.strip())

        if not named:
            if len(positional) == 1:
                return {"_value": positional[0]}
            return {"_values": positional}

        if positional:
            named["_values"] = positional

        return named

    def parse_modifier_chain(self, modifier_text: str) -> Dict[str, Any]:
        mods = {}
        if not modifier_text or "Modifier" not in modifier_text:
            return mods

        remaining = modifier_text
        while True:
            match = re.search(r'\.(\w+)\s*\(', remaining)
            if not match:
                break

            mod_name = match.group(1)
            start = match.end() - 1

            depth = 1
            end = start + 1
            while depth > 0 and end < len(remaining):
                if remaining[end] == '(':
                    depth += 1
                elif remaining[end] == ')':
                    depth -= 1
                end += 1

            args_text = remaining[start + 1:end - 1]
            remaining = remaining[end:]

            args = self.parse_argument_map(args_text)
            mods[mod_name] = args

        for quick in ["fillMaxWidth", "fillMaxHeight", "fillMaxSize",
                      "wrapContentWidth", "wrapContentHeight", "wrapContentSize"]:
            if f".{quick}()" in modifier_text:
                mods[quick] = True

        return mods

    def resolve_color(self, value: str) -> Optional[str]:
        if not isinstance(value, str):
            return None
        val = value.strip()

        match = re.match(r'Color\s*\(\s*(0x[0-9A-Fa-f]+)\s*\)', val)
        if match:
            hex_val = match.group(1)[2:]
            if len(hex_val) == 8:
                hex_val = hex_val[2:]
            return f"#{hex_val.upper()}"

        match = re.match(r'MaterialTheme\.colorScheme\.(\w+)', val)
        if match:
            key = match.group(1)
            return self.theme_colors.get(key)

        match = re.match(r'AppTokens\.Colors\.(\w+)', val)
        if match:
            key = match.group(1)
            return self.theme_colors.get(key)

        if re.match(r'^#[0-9A-Fa-f]{6}$', val):
            return val.upper()

        return None

    def resolve_dimension(self, value: str) -> Optional[str]:
        if not isinstance(value, str):
            return None
        val = value.strip()

        match = re.match(r'AppTokens\.Spacing\.(\w+)', val)
        if match:
            return self.spacing_tokens.get(match.group(1))

        match = re.match(r'^(\d+(?:\.\d+)?)\s*\.?dp$', val, re.IGNORECASE)
        if match:
            return match.group(1)

        match = re.match(r'^(\d+(?:\.\d+)?)\s*\.?sp$', val, re.IGNORECASE)
        if match:
            return match.group(1)

        return None

    def normalize_value(self, value: str, context: str = "") -> Any:
        if not isinstance(value, str):
            return value

        val = value.strip()

        color = self.resolve_color(val)
        if color:
            return color

        dim = self.resolve_dimension(val)
        if dim:
            return dim

        if val.startswith('"') and val.endswith('"'):
            inner = val[1:-1]
            if '${' in inner or '$' in inner:
                return {"_type": "template", "value": inner}
            return inner

        if val.startswith('{') and val.endswith('}'):
            return {"_type": "lambda", "value": val}

        if "FontWeight." in val:
            weight_map = {
                "FontWeight.SemiBold": "FontWeight.Medium",
                "FontWeight.Regular": "FontWeight.Normal",
                "FontWeight.Light": "FontWeight.Normal",
                "FontWeight.Thin": "FontWeight.Normal",
                "FontWeight.Black": "FontWeight.Bolder",
                "FontWeight.ExtraBold": "FontWeight.Bolder",
                "FontWeight.ExtraLight": "FontWeight.Normal",
            }
            for kotlin_w, arkts_w in weight_map.items():
                if kotlin_w in val:
                    return arkts_w
            return val

        return val

    def find_call_name(self, node) -> Optional[str]:
        if node.type != "call_expression":
            return None

        for child in node.children:
            if child.type in ("simple_identifier", "identifier"):
                return self.get_text(child)
            elif child.type == "navigation_expression":
                text = self.get_text(child)
                if '.' in text:
                    return text.split('.')[-1]
                return text
            elif child.type == "call_expression":
                return self.find_call_name(child)

        return None

    def extract_value_argument(self, arg_node) -> Tuple[Optional[str], Any]:
        if arg_node.type != "value_argument":
            return None, None

        arg_text = self.get_text(arg_node)

        name_node = None
        value_node = None

        for child in arg_node.children:
            if child.type == "simple_identifier":
                name_node = child
            elif child.type in ["value_argument", "expression", "primary_expression",
                               "string_literal", "integer_literal", "floating_point_literal",
                               "callable_reference", "lambda_literal", "function_literal",
                               "call_expression", "navigation_expression"]:
                value_node = child

        name = self.get_text(name_node) if name_node else None

        if not value_node:
            return name, None

        value_text = self.get_text(value_node)

        if value_node.type == "string_literal":
            val = value_text.strip('"\'')
            return name, val

        elif value_node.type in ["integer_literal", "floating_point_literal"]:
            return name, value_text

        elif value_node.type == "lambda_literal":
            return name, {"_type": "lambda", "node": value_node}

        elif value_node.type == "call_expression":
            nested = self.parse_ui_component(value_node)
            if nested:
                return name, {"_type": "component", "node": nested}
            return name, self.normalize_value(value_text)

        else:
            return name, self.normalize_value(value_text)

    def parse_ui_component(self, node) -> Optional[UINode]:
        if node.type != "call_expression":
            return None

        comp_name = self.find_call_name(node)
        if not comp_name or not self.is_component_name(comp_name):
            return None

        if comp_name in self.WRAPPER_COMPONENTS:
            return None

        ui_node = UINode(
            component=comp_name,
            source_range=(self.get_line_number(node),
                         self.get_line_number(node) + self.get_text(node).count('\n'))
        )

        value_args_found = False

        for child in node.children:
            if child.type == "value_arguments":
                value_args_found = True
                for arg in child.children:
                    if arg.type == "value_argument":
                        self._parse_argument_to_node(arg, ui_node)

            elif child.type in ["lambda_literal", "annotated_lambda", "function_literal"]:
                children = self._parse_lambda_content(child)
                ui_node.children.extend(children)

        if not value_args_found:
            for child in node.children:
                if child.type == "call_expression":
                    for sub in child.children:
                        if sub.type == "value_arguments":
                            for arg in sub.children:
                                if arg.type == "value_argument":
                                    self._parse_argument_to_node(arg, ui_node)

        return ui_node

    def _parse_argument_to_node(self, arg_node, ui_node: UINode):
        arg_text = self.get_text(arg_node)

        if '=' in arg_text:
            parts = arg_text.split('=', 1)
            key = parts[0].strip()
            value = parts[1].strip()

            if key == "modifier" and "Modifier" in value:
                mods = self.parse_modifier_chain(value)
                ui_node.modifier.update(mods)
                return

            if key in ["contentAlignment", "align", "alignment"]:
                ui_node.props[key] = self._extract_alignment(value)
                return

            if key in ["horizontalArrangement", "verticalArrangement"]:
                arrangement = self._extract_arrangement(value)
                if arrangement:
                    ui_node.props[key] = arrangement
                    if arrangement.get("type") == "spacedBy":
                        ui_node.props["space"] = arrangement.get("value")
                return

            value_node = None
            for child in arg_node.children:
                if child.type in ["(", ")", ",", " ", "simple_identifier", "=", "identifier"]:
                    continue
                value_node = child
                break

            if value_node and value_node.type in ["lambda_literal", "annotated_lambda", "function_literal"]:
                children = self._parse_lambda_content(value_node)
                ui_node.children.extend(children)
            else:
                ui_node.props[key] = self.normalize_value(value, key)

        else:
            value_node = None
            for child in arg_node.children:
                if child.type not in ["(", ")", ",", " "]:
                    value_node = child
                    break

            if value_node:
                value_text = self.get_text(value_node)

                if value_node.type in ["lambda_literal", "annotated_lambda"]:
                    children = self._parse_lambda_content(value_node)
                    ui_node.children.extend(children)
                else:
                    ui_node.props["text"] = self.normalize_value(value_text)

    def _extract_alignment(self, value: str) -> str:
        match = re.search(r'Alignment\.(\w+)', value)
        if match:
            return f"Alignment.{match.group(1)}"
        return value.strip()

    def _extract_arrangement(self, value: str) -> Dict:
        if "spacedBy" in value:
            match = re.search(r'spacedBy\s*\(\s*([^)]+)\s*\)', value)
            if match:
                space_val = match.group(1).strip()
                resolved = self.resolve_dimension(space_val)
                return {
                    "type": "spacedBy",
                    "value": resolved or space_val.replace(".dp", "").replace(".sp", "")
                }

        match = re.search(r'Arrangement\.(\w+)', value)
        if match:
            return {"type": match.group(1)}

        return {"type": value.strip()}

    def _parse_lambda_content(self, lambda_node) -> List[UINode]:
        children = []

        for child in lambda_node.children:
            if child.type in ["statements", "block", "lambda_body"]:
                for stmt in child.children:
                    ui = self._find_ui_in_node(stmt)
                    children.extend(ui)
            else:
                ui = self._find_ui_in_node(child)
                children.extend(ui)

        return children

    def _find_ui_in_node(self, node) -> List[UINode]:
        results = []

        if node.type == "call_expression":
            ui = self.parse_ui_component(node)
            if ui:
                results.append(ui)
            else:
                for child in node.children:
                    results.extend(self._find_ui_in_node(child))

        elif hasattr(node, 'children') and node.children:
            for child in node.children:
                results.extend(self._find_ui_in_node(child))

        return results

    def extract_theme_info(self):
        color_patterns = [
            (r'val\s+(\w+)\s*=\s*Color\s*\(\s*0xFF([0-9A-Fa-f]{6})\s*\)', "hex"),
            (r'(\w+)\s*:\s*Color\s*\(\s*0xFF([0-9A-Fa-f]{6})\s*\)', "hex"),
        ]

        for pattern, fmt in color_patterns:
            for match in re.finditer(pattern, self.source_str):
                name = match.group(1)
                hex_val = match.group(2).upper()
                self.theme_colors[name] = f"#{hex_val}"

        spacing_pattern = r'val\s+(\w+)\s*=\s*(\d+(?:\.\d+)?)\s*\.dp'
        for match in re.finditer(spacing_pattern, self.source_str):
            self.spacing_tokens[match.group(1)] = match.group(2)

        typography_pattern = r'val\s+(\w+)\s*=\s*TextStyle\s*\((.*?)\)'
        for match in re.finditer(typography_pattern, self.source_str, re.DOTALL):
            name = match.group(1)
            args_text = match.group(2)
            args = self.parse_argument_map(args_text)
            self.typography_tokens[name] = {
                k: self.normalize_value(v, k)
                for k, v in args.items()
            }

    def find_composable_functions(self) -> Dict[str, Dict[str, Any]]:
        composables = {}

        tree = self.parser.parse(self.source_bytes)
        root = tree.root_node

        def traverse(node):
            if node.type == "function_declaration":
                has_composable = False
                for child in node.children:
                    if child.type == "modifiers":
                        mod_text = self.get_text(child)
                        if "@Composable" in mod_text:
                            has_composable = True
                            break

                if not has_composable:
                    for child in node.children:
                        traverse(child)
                    return

                name = None
                for child in node.children:
                    if child.type in ("simple_identifier", "identifier"):
                        name = self.get_text(child)
                        break

                if not name:
                    return

                for child in node.children:
                    if child.type == "function_body":
                        body_children = self._find_ui_in_node(child)
                        state_vars = self._extract_state_variables_from_body(child)
                        composables[name] = {
                            "ui_nodes": body_children,
                            "state_vars": state_vars
                        }
                        break

            else:
                for child in node.children or []:
                    traverse(child)

        traverse(root)
        return composables

    def _extract_state_variables_from_body(self, body_node) -> Dict[str, Dict[str, Any]]:
        state_vars = {}
        body_text = self.get_text(body_node)
        
        def extract_paren_content(text, start_idx):
            if start_idx >= len(text) or text[start_idx] != '(':
                return None
            depth = 1
            i = start_idx + 1
            while i < len(text) and depth > 0:
                if text[i] == '(':
                    depth += 1
                elif text[i] == ')':
                    depth -= 1
                i += 1
            if depth == 0:
                return text[start_idx+1:i-1]
            return None
        
        val_pattern = r'val\s+(\w+)\s*=\s*'
        for match in re.finditer(val_pattern, body_text):
            var_name = match.group(1)
            pos = match.end()
            
            remember_match = re.match(r'remember\s*\{', body_text[pos:])
            if remember_match:
                pos += remember_match.end()
            
            state_match = re.match(r'\s*(mutableStateOf|mutableStateListOf)\s*', body_text[pos:])
            if state_match:
                func_name = state_match.group(1)
                pos += state_match.end()
                
                content = extract_paren_content(body_text, pos)
                if content is not None:
                    content = content.strip()
                    if func_name == "mutableStateOf":
                        var_type = self._infer_state_type(content)
                        state_vars[var_name] = {
                            "type": var_type,
                            "initial_value": content
                        }
                    else:
                        state_vars[var_name] = {
                            "type": "array",
                            "initial_value": f"[{content}]" if content else "[]"
                        }
        
        return state_vars

    def _infer_state_type(self, value: str) -> str:
        value = value.strip()
        
        if value.startswith('"') or value.startswith('"""'):
            return "string"
        
        if value in ["true", "false"]:
            return "boolean"
        
        if re.match(r'^-?\d+$', value):
            return "number"
        if re.match(r'^-?\d+\.\d+$', value):
            return "number"
        
        if value.startswith("Color("):
            return "string"
        
        return "any"

    def extract_data_classes(self):
        pattern = r'data\s+class\s+(\w+)'
        for match in re.finditer(pattern, self.source_str):
            self.data_classes.add(match.group(1))

    def parse(self, source_code: str) -> Dict[str, Any]:
        self.source_str = source_code
        self.source_bytes = source_code.encode('utf-8')

        self.extract_data_classes()
        self.extract_theme_info()
        composables = self.find_composable_functions()

        main_ui = []
        main_state_vars = {}
        
        if "RootScreen" in composables:
            main_ui = composables["RootScreen"]["ui_nodes"]
            main_state_vars = composables["RootScreen"]["state_vars"]
        elif composables:
            first = list(composables.values())[0]
            main_ui = first["ui_nodes"]
            main_state_vars = first["state_vars"]

        main_ui = self._inline_custom_components(main_ui, composables)

        return {
            "theme": {
                "colors": self.theme_colors,
                "spacing": self.spacing_tokens,
                "typography": self.typography_tokens
            },
            "ui_structure": [node.to_dict() for node in main_ui],
            "state_variables": main_state_vars,
            "metadata": {
                "composables_found": list(composables.keys()),
                "total_components": len(main_ui),
                "state_variables_count": len(main_state_vars)
            }
        }

    def _inline_custom_components(self, nodes: List[UINode],
                                  composables: Dict[str, Dict[str, Any]],
                                  visited: set = None) -> List[UINode]:
        if visited is None:
            visited = set()

        result = []
        for node in nodes:
            comp_name = node.component

            if comp_name in composables and comp_name not in visited:
                visited.add(comp_name)
                inlined = self._inline_custom_components(
                    [self._copy_node(n) for n in composables[comp_name]["ui_nodes"]],
                    composables,
                    visited
                )
                visited.discard(comp_name)
                result.extend(inlined)
            else:
                new_node = self._copy_node(node)
                new_node.children = self._inline_custom_components(node.children, composables, visited)
                result.append(new_node)

        return result

    def _copy_node(self, node: UINode) -> UINode:
        import copy
        return UINode(
            component=node.component,
            props=copy.deepcopy(node.props),
            modifier=copy.deepcopy(node.modifier),
            children=[],
            source_range=node.source_range
        )


def main():
    import argparse

    parser = argparse.ArgumentParser(description="Parse Kotlin Compose UI to JSON tree")
    parser.add_argument("input", help="Input Kotlin file or directory")
    parser.add_argument("-o", "--output", default="output.json", help="Output JSON file")
    parser.add_argument("--indent", type=int, default=2, help="JSON indent level")

    args = parser.parse_args()

    parser_obj = KotlinUIParser()

    if os.path.isdir(args.input):
        for root, _, files in os.walk(args.input):
            for file in files:
                if file.endswith(".kt"):
                    filepath = os.path.join(root, file)
                    with open(filepath, 'r', encoding='utf-8') as f:
                        source = f.read()

                    result = parser_obj.parse(source)

                    rel_path = os.path.relpath(filepath, args.input)
                    out_path = os.path.join(args.output, rel_path.replace(".kt", ".json"))
                    os.makedirs(os.path.dirname(out_path), exist_ok=True)

                    with open(out_path, 'w', encoding='utf-8') as f:
                        json.dump(result, f, indent=args.indent, ensure_ascii=False)

                    print(f"[tree_kt] {filepath} -> {out_path}")
    else:
        with open(args.input, 'r', encoding='utf-8') as f:
            source = f.read()

        result = parser_obj.parse(source)

        with open(args.output, 'w', encoding='utf-8') as f:
            json.dump(result, f, indent=args.indent, ensure_ascii=False)

        print(f"[tree_kt] {args.input} -> {args.output}")


if __name__ == "__main__":
    main()

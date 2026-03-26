
"""Swift UI Parser - Extract UI component hierarchy and theme from SwiftUI files."""

import os
import json
import re
import sys
from tree_sitter import Language, Parser
import tree_sitter_swift as tsswift


class SwiftUIExtractor:
    def __init__(self):
        self.language = Language(tsswift.language())
        self.parser = Parser(self.language)
        # Blacklist: things to skip (not UI components)
        self.blacklist = {
            "Color", "Divider", "EmptyView",
            # "ForEach", "Group",
            "AnyView", "some", "View",
            "opacity", "font", "foregroundColor", "frame", "padding", "fill",
            "overlay", "stroke", "lineWidth", "onSurface", "Colors", "Type",
            "private", "Double", "CGFloat", "Array", "String", "CGPoint", "CGRect", "Angle",
            # Design token namespaces
            "AppTokens", "QuizTokens", "PT", "MP", "DP", "DM", "DesignTokens",
            "Tokens", "ThemeTokens", "StyleTokens",
            # Navigation/Style types (not Views)
            "StackNavigationViewStyle", "NavigationViewStyle", "TabViewStyle",
            # Other non-View types
            "Font", "CGSize", "UIColor", "ColorScheme", "EdgeInsets",
            "Binding", "CGVector", "State", "ObservedObject", "Environment",
            "GeometryReader",
        }

    def _clean_text(self, text):
        """Normalize whitespace in text."""
        if not text:
            return ""
        return re.sub(r"\s+", " ", text).strip()

    def get_text(self, node, source):
        """Extract text from AST node and normalize whitespace."""
        if not node:
            return ""
        text = source[node.start_byte:node.end_byte].decode("utf-8")
        return self._clean_text(text)

    def _split_modifier_chain(self, raw_text: str):
        """Split chained modifiers safely, handling nested parentheses and braces."""
        mods = []
        buf = []
        depth_paren = 0
        depth_brace = 0

        i = 0
        while i < len(raw_text):
            ch = raw_text[i]
            if ch == "(":
                depth_paren += 1
            elif ch == ")":
                depth_paren = max(0, depth_paren - 1)
            elif ch == "{":
                depth_brace += 1
            elif ch == "}":
                depth_brace = max(0, depth_brace - 1)

            if ch == "." and depth_paren == 0 and depth_brace == 0:
                s = "".join(buf).strip()
                if s:
                    mods.append(s)
                buf = ["."]
            else:
                buf.append(ch)
            i += 1

        tail = "".join(buf).strip()
        if tail:
            mods.append(tail)

        return [m for m in mods if m.startswith(".")]

    def _add_modifier(self, component, mod_name: str, full_call: str):
        """Add modifier while preserving order and allowing duplicates."""
        component["modifiers"].append({"name": mod_name, "raw": full_call})
        if mod_name in component["modifier"]:
            prev = component["modifier"][mod_name]
            if isinstance(prev, list):
                prev.append(full_call)
            else:
                component["modifier"][mod_name] = [prev, full_call]
        else:
            component["modifier"][mod_name] = full_call

    def extract_node(self, node, source):
        """Extract a single SwiftUI component from a call_expression node."""
        if node.type != "call_expression":
            return None

        call_text = self.get_text(node, source)
        match = re.match(r"([A-Za-z_]\w*)", call_text)
        if not match:
            return None

        comp_name = match.group(1)

        # Filter: must start with uppercase, not in blacklist
        if not comp_name[0].isupper() or comp_name in self.blacklist:
            return None

        # Skip design token namespaces (2-4 uppercase letters)
        if 2 <= len(comp_name) <= 4 and comp_name.isupper():
            return None
        
        # Skip design system tokens (XXXTokens pattern)
        if comp_name.endswith("Tokens"):
            return None

        component = {
            "component": comp_name,
            "modifier": {},   # backward compatible (may be dict or dict-of-lists)
            "modifiers": [],  # ordered list of modifiers (preferred)
            "props": {},
            "children": []
        }

        modifiers = self._extract_modifiers_from_call(node, source)
        for mod_name, full_call in modifiers:
            self._add_modifier(component, mod_name, full_call)
        
        self._extract_all(node, source, component)

        return component

    def _extract_all(self, node, source, component):
        """Recursively extract parameters, modifiers, and children from a node."""
        for child in node.children:
            if child.type == "call_suffix":
                self._extract_from_suffix(child, source, component)
            elif child.type == "navigation_expression":
                self._extract_from_navigation(child, source, component)
            elif child.type == "lambda_literal":
                children = self.find_ui_recursive(child, source)
                component["children"].extend(children)

    def _extract_from_suffix(self, suffix_node, source, component):
        """Extract parameters and closures from call_suffix node."""
        for child in suffix_node.children:
            if child.type == "value_arguments":
                for arg in child.children:
                    if arg.type == "value_argument":
                        self._parse_argument(arg, source, component)
            elif child.type == "lambda_literal":
                children = self.find_ui_recursive(child, source)
                component["children"].extend(children)

    def _extract_modifiers_from_call(self, call_node, source, visited=None):
        """Extract modifiers from a call_expression that may have navigation/modifiers."""
        if visited is None:
            visited = set()
        
        node_id = (call_node.start_byte, call_node.end_byte)
        if node_id in visited:
            return []
        visited.add(node_id)
        
        modifiers = []
        
        if call_node.type != "call_expression":
            return modifiers
        nav_node = None
        call_suffix = None
        
        for child in call_node.children:
            if child.type == "navigation_expression":
                nav_node = child
            elif child.type == "call_suffix":
                call_suffix = child
        
        if nav_node:
            suffix_node = None
            base_call = None
            
            for child in nav_node.children:
                if child.type == "navigation_suffix":
                    suffix_node = child
                elif child.type == "call_expression":
                    base_call = child
            
            if suffix_node:
                mod_name = self._clean_text(
                    source[suffix_node.start_byte:suffix_node.end_byte].decode("utf-8")
                ).lstrip(".")
                
                full_call = mod_name
                if call_suffix:
                    args_text = self._clean_text(
                        source[call_suffix.start_byte:call_suffix.end_byte].decode("utf-8")
                    )
                    full_call = f"{mod_name}{args_text}"
                
                modifiers.append((mod_name, full_call))
            
            if base_call:
                parent_mods = self._extract_modifiers_from_call(base_call, source, visited)
                modifiers.extend(parent_mods)
        
        return modifiers

    def _extract_from_navigation(self, nav_node, source, component):
        """Extract modifiers from navigation_expression (modifier chains)."""
        for child in nav_node.children:
            if child.type == "call_expression":
                self._extract_all(child, source, component)
            elif child.type == "lambda_literal":
                children = self.find_ui_recursive(child, source)
                if children:
                    component["children"].extend(children)

    def _parse_argument(self, arg_node, source, component):
        """Parse a single function argument."""
        arg_text = self.get_text(arg_node, source)

        raw_bytes = source[arg_node.start_byte:arg_node.end_byte].decode("utf-8")
        raw_text = self._clean_text(raw_bytes)

        if ":" in arg_text:
            k, v = arg_text.split(":", 1)
            k, v = k.strip(), v.strip()

            if "{" in v or "(" in v:
                children = self.find_ui_recursive(arg_node, source)
                if children:
                    component["children"].extend(children)
                
                colon_idx = raw_text.find(":")
                val_cleaned = raw_text[colon_idx + 1:].strip() if colon_idx != -1 else v
                component["props"][k] = val_cleaned
            else:
                component["props"][k] = v
        else:
            if arg_text.startswith('"') and arg_text.endswith('"'):
                if "text" not in component["props"]:
                    component["props"]["text"] = arg_text[1:-1]
                    component["props"]["_text_raw"] = arg_text
                else:
                    component["props"].setdefault("texts", []).append(arg_text[1:-1])
                    component["props"].setdefault("_texts_raw", []).append(arg_text)
            else:
                children = self.find_ui_recursive(arg_node, source)
                if children:
                    component["children"].extend(children)
                else:
                    component["props"].setdefault("_positional_raw", []).append(raw_text)

    def find_ui_recursive(self, root_node, source, depth=0, view_builders=None):
        """Recursively find all UI components in subtree."""
        if depth > 20:
            return []

        components = []
        for child in root_node.children:
            if child.type == "call_expression":
                comp = self.extract_node(child, source)
                if comp:
                    if view_builders and comp.get("children"):
                        comp["children"] = self.find_ui_recursive(
                            self._find_lambda_or_body(child, source) or child, 
                            source, depth + 1, view_builders
                        )
                    components.append(comp)
                else:
                    components.extend(self.find_ui_recursive(child, source, depth + 1, view_builders))
            elif child.type == "simple_identifier" and view_builders:
                ident_name = self.get_text(child, source)
                if ident_name in view_builders:
                    builder_components = view_builders[ident_name]
                    if builder_components:
                        import copy
                        components.extend(copy.deepcopy(builder_components))
                    continue
                if child.children:
                    components.extend(self.find_ui_recursive(child, source, depth + 1, view_builders))
            else:
                if child.children:
                    components.extend(self.find_ui_recursive(child, source, depth + 1, view_builders))

        return components
    
    def _find_lambda_or_body(self, call_node, source):
        """Find lambda_literal or trailing closure in a call expression."""
        for child in call_node.children:
            if child.type == "lambda_literal":
                return child
            if child.children:
                result = self._find_lambda_or_body(child, source)
                if result:
                    return result
        return None

    def collect_view_bodies(self, root_node, source):
        """Collect all View struct/class body properties and their UI trees."""
        views = {}
        view_builder_nodes = {}
        stack = [root_node]
        while stack:
            node = stack.pop()

            if node.type in ("class_declaration", "struct_declaration"):
                view_name = None
                for child in node.children:
                    if child.type == "type_identifier":
                        view_name = self.get_text(child, source)
                        break

                if not view_name:
                    stack.extend(node.children or [])
                    continue

                for child in node.children:
                    if child.type in ("class_body", "struct_body"):
                        for body_child in child.children:
                            if body_child.type == "property_declaration":
                                text = self.get_text(body_child, source)
                                # Main body property
                                if re.search(r"\bvar\s+body\b", text):
                                    for subchild in body_child.children:
                                        if subchild.type == "computed_property":
                                            # Store node for second pass
                                            view_builder_nodes[view_name] = (subchild, True)  # True = is main body
                                            break
                                # Computed properties returning some View
                                elif re.search(r"\bvar\s+(\w+)\s*:\s*some\s+View\b", text):
                                    match = re.search(r"\bvar\s+(\w+)\s*:\s*some\s+View\b", text)
                                    if match:
                                        builder_name = match.group(1)
                                        for subchild in body_child.children:
                                            if subchild.type == "computed_property":
                                                view_builder_nodes[builder_name] = (subchild, False)
                                                break
                            
                            # Functions returning some View
                            elif body_child.type == "function_declaration":
                                text = self.get_text(body_child, source)
                                if re.search(r"\bfunc\s+(\w+)\s*\([^)]*\)\s*(?:->\s*some\s+View)\b", text):
                                    match = re.search(r"\bfunc\s+(\w+)\s*\([^)]*\)", text)
                                    if match:
                                        func_name = match.group(1)
                                        for subchild in body_child.children:
                                            if subchild.type in ("function_body", "computed_property"):
                                                view_builder_nodes[func_name] = (subchild, False)
                                                break

            stack.extend(node.children or [])

        view_builders = {}
        
        for name, (node, is_main_body) in view_builder_nodes.items():
            if not is_main_body:
                view_builders[name] = self.find_ui_recursive(node, source, view_builders=view_builders)
        
        main_views = {}
        for name, (node, is_main_body) in view_builder_nodes.items():
            if is_main_body:
                ui_tree = self.find_ui_recursive(node, source, view_builders=view_builders)
                main_views[name] = ui_tree
        if main_views:
            def count_components(tree):
                if not tree:
                    return 0
                count = 0
                for node in tree:
                    count += 1
                    count += count_components(node.get("children", []))
                return count
            
            best_view_name = max(main_views.keys(), key=lambda n: count_components(main_views[n]))
            views[best_view_name] = main_views[best_view_name]

        return views, view_builders

    def expand_view_references(self, components, view_builders, source, depth=0):
        """Expand references to view builders inline."""
        if depth > 10:
            return components
            
        expanded = []
        for comp in components:
            comp_name = comp.get("component", "")
            if comp_name in view_builders and not comp.get("children"):
                builder_content = view_builders[comp_name]
                if builder_content:
                    for child in builder_content:
                        child_copy = child.copy()
                        child_copy["_expanded_from"] = comp_name
                        expanded.append(child_copy)
                else:
                    expanded.append(comp)
            else:
                new_comp = comp.copy()
                if comp.get("children"):
                    new_comp["children"] = self.expand_view_references(comp["children"], view_builders, source, depth + 1)
                expanded.append(new_comp)
        
        return expanded

    def extract_state_variables(self, source_str, theme_colors=None, theme_fonts=None, 
                                theme_spacing=None, theme_shapes=None):
        """Extract @State and other property variables from Swift source."""
        theme_colors = theme_colors or set()
        theme_fonts = theme_fonts or set()
        theme_spacing = theme_spacing or set()
        theme_shapes = theme_shapes or set()
        
        # Combine all theme items to exclude
        all_theme_items = theme_colors | theme_fonts | theme_spacing | theme_shapes
        
        state_vars = {}
        
        state_pattern = r'@State\s+(?:private\s+)?var\s+(\w+)\s*(?::\s*([\[\]\w<>,\s]+))?\s*=\s*([^\n]+)'
        for match in re.finditer(state_pattern, source_str):
            name = match.group(1)
            # Skip if it's a theme item
            if name in all_theme_items:
                continue
            type_hint = match.group(2)
            default_value = match.group(3).strip()
            var_type = type_hint or self._infer_swift_type(default_value)
            state_vars[name] = {
                "type": var_type,
                "default": default_value,
                "storage": "@State"
            }
        
        binding_pattern = r'@(Binding|ObservedObject|EnvironmentObject)\s+var\s+(\w+)'
        for match in re.finditer(binding_pattern, source_str):
            var_name = match.group(2)
            if var_name in all_theme_items:
                continue
            state_vars[var_name] = {
                "type": match.group(1),
                "default": "",
                "storage": "@Binding"
            }
        
        let_pattern = r'(?:private\s+)?let\s+(\w+)\s*(?::\s*([\[\]\w<>,\s]+))?\s*=\s*([^\n]+)'
        for match in re.finditer(let_pattern, source_str):
            name = match.group(1)
            # Skip if already in state_vars or is a theme item
            if name in state_vars or name in all_theme_items:
                continue
            type_hint = match.group(2)
            default_value = match.group(3).strip()
            var_type = type_hint or self._infer_swift_type(default_value)
            state_vars[name] = {
                "type": var_type,
                "default": default_value,
                "storage": "let"
            }
        
        return state_vars

    def _infer_swift_type(self, value: str) -> str:
        """Infer Swift type from value."""
        value = value.strip()
        
        # String
        if value.startswith('"') and value.endswith('"'):
            return "String"
        
        # Array
        if value.startswith('[') and value.endswith(']'):
            return "Array"
        
        # Dictionary/Set
        if value.startswith('[') and ':' in value:
            return "Dictionary"
        if value.startswith('Set'):
            return "Set"
        
        # Number
        if re.match(r'^-?\d+$', value):
            return "Int"
        if re.match(r'^-?\d+\.\d+$', value):
            return "Double"
        
        # Bool
        if value in ["true", "false"]:
            return "Bool"
        
        # Color
        if value.startswith("Color"):
            return "Color"
        
        # Closure
        if value.startswith("{"):
            return "Closure"
        
        return "any"

    def extract_colors(self, source_str):
        """Extract color definitions from Swift source."""
        colors = {}
        clean_source = re.sub(r"\s+", " ", source_str)
        hex_matches = re.findall(
            r"(?:let|static let)\s+(\w+)\s*=\s*Color\(hex:\s*(0x[\dA-Fa-f]+)\)",
            clean_source,
        )
        for name, hex_val in hex_matches:
            colors[name] = hex_val
        
        # Nested Color format
        nested_hex_matches = re.findall(
            r"(?:let|static let)\s+(\w+)\s*=\s*Color\(Color\(hex:\s*(0x[\dA-Fa-f]+)\)\)",
            clean_source,
        )
        for name, hex_val in nested_hex_matches:
            colors[name] = hex_val
        
        # hexRGB format
        hexrgb_matches = re.findall(
            r"(?:let|static let)\s+(\w+)\s*=\s*Color\(hexRGB:\s*(0x[\dA-Fa-f]+)\)",
            clean_source,
        )
        for name, hex_val in hexrgb_matches:
            colors[name] = hex_val
        
        # Direct hex literal
        hex_direct_matches = re.findall(
            r"(?:let|static let)\s+(\w+)\s*=\s*Color\(\s*(0x[\dA-Fa-f]{6,8})\s*\)",
            clean_source,
        )
        for name, hex_val in hex_direct_matches:
            colors[name] = hex_val
        
        # String hex format
        hex_str_matches = re.findall(
            r"(?:let|static let)\s+(\w+)\s*=\s*Color\(hex:\s*\"([0-9A-Fa-f]{6})\"\)",
            clean_source,
        )
        for name, hex_val in hex_str_matches:
            colors[name] = f"#{hex_val}"
        
        # RGB format
        rgb_matches = re.findall(
            r"(?:let|static let)\s+(\w+)\s*=\s*Color\(red:\s*(0x[0-9A-Fa-f]+(?:\s*/\s*(?:255\.?0?))?|[0-9./]+)\s*,\s*green:\s*(0x[0-9A-Fa-f]+(?:\s*/\s*(?:255\.?0?))?|[0-9./]+)\s*,\s*blue:\s*(0x[0-9A-Fa-f]+(?:\s*/\s*(?:255\.?0?))?|[0-9./]+)\s*\)",
            clean_source,
        )
        for name, r, g, b in rgb_matches:
            try:
                def parse_color_val(v):
                    v = v.strip()
                    if v.startswith('0x'):
                        if '/' in v:
                            hex_part, denom = v.split('/', 1)
                            return int(hex_part, 16) / float(denom.strip().replace('.0', ''))
                        else:
                            return int(v, 16)
                    if '/' in v:
                        num, den = v.split('/')
                        return float(num) / float(den)
                    return float(v)
                
                rv, gv, bv = parse_color_val(r), parse_color_val(g), parse_color_val(b)
                if rv <= 1.0 and gv <= 1.0 and bv <= 1.0:
                    rv, gv, bv = rv * 255, gv * 255, bv * 255
                
                hex_color = "#{:02X}{:02X}{:02X}".format(
                    int(rv), int(gv), int(bv)
                )
                colors[name] = hex_color
            except (ValueError, OverflowError, ZeroDivisionError):
                pass
        
        # Standard color references
        std_matches = re.findall(
            r"(?:let|static let)\s+(\w+)\s*=\s*Color\.(\w+)",
            clean_source,
        )
        for name, color_name in std_matches:
            std_colors = {
                "white": "#FFFFFF", "black": "#000000", "red": "#FF0000",
                "green": "#00FF00", "blue": "#0000FF", "yellow": "#FFFF00",
                "orange": "#FFA500", "purple": "#800080", "pink": "#FFC0CB",
                "gray": "#808080", "grey": "#808080", "clear": "#00000000",
                "cyan": "#00FFFF", "magenta": "#FF00FF", "brown": "#A52A2A",
            }
            if color_name in std_colors:
                colors[name] = std_colors[color_name]
            else:
                colors[name] = f"Color.{color_name}"
        
        return colors

    def extract_fonts(self, source_str):
        """Extract font definitions from Swift source."""
        fonts = {}
        clean_source = re.sub(r"\s+", " ", source_str)
        
        font_matches = re.findall(
            r"static\s+let\s+(\w+)\s*=\s*Font\.system\((.*?)\)",
            clean_source,
        )
        for name, params in font_matches:
            fonts[name] = params.strip()
        return fonts

    def extract_spacing(self, source_str):
        """Extract spacing token definitions from Swift source."""
        spacing = {}
        spacing_pattern = r'(?:let|static let)\s+(\w+)\s*(?::\s*(?:CGFloat|Int|Double))?\s*=\s*(\d+(?:\.\d+)?)'
        for match in re.finditer(spacing_pattern, source_str):
            name = match.group(1)
            value = match.group(2)
            if len(name) <= 5 and name.islower() and name not in ['width', 'height', 'x', 'y']:
                spacing[name] = value
        return spacing

    def extract_shapes(self, source_str):
        """Extract shape token definitions from Swift source."""
        shapes = {}
        shape_pattern = r'(?:let|static let)\s+(\w+)\s*=\s*(RoundedRectangle|Circle|Capsule|Rectangle)\s*\([^)]+\)'
        for match in re.finditer(shape_pattern, source_str):
            name = match.group(1)
            shape_type = match.group(2)
            shapes[name] = shape_type
        return shapes

    def find_entry_point_from_window_group(self, root_node, source):
        """Find the main entry point by looking inside WindowGroup."""
        stack = [root_node]

        while stack:
            node = stack.pop()

            if node.type == "call_expression":
                text = self.get_text(node, source)
                if text.startswith("WindowGroup"):
                    entry_candidates = []
                    self._collect_components_from_window_group(node, source, entry_candidates)
                    if entry_candidates:
                        return entry_candidates[-1]

            stack.extend(node.children or [])

        return None

    def _collect_components_from_window_group(self, node, source, candidates):
        """Collect all component calls inside WindowGroup in order."""
        for child in node.children:
            if child.type == "call_suffix":
                for suffix_child in child.children:
                    if suffix_child.type == "lambda_literal":
                        self._extract_components_from_lambda(suffix_child, source, candidates)
            elif child.type == "navigation_expression":
                for nav_child in child.children:
                    if nav_child.type == "call_expression":
                        self._collect_components_from_window_group(nav_child, source, candidates)

    def _extract_components_from_lambda(self, lambda_node, source, candidates):
        """Extract all component calls from inside a lambda_literal."""
        for child in lambda_node.children:
            if child.type == "call_expression":
                entry_text = self.get_text(child, source)
                match = re.match(r"([A-Za-z_]\w*)", entry_text)
                if match and match.group(1)[0].isupper():
                    name = match.group(1)
                    if not (2 <= len(name) <= 4 and name.isupper()) and name not in self.blacklist:
                        candidates.append(name)
            elif child.type == "statements":
                for stmt in child.children:
                    if stmt.type == "call_expression":
                        entry_text = self.get_text(stmt, source)
                        match = re.match(r"([A-Za-z_]\w*)", entry_text)
                        if match and match.group(1)[0].isupper():
                            name = match.group(1)
                            if not (2 <= len(name) <= 4 and name.isupper()) and name not in self.blacklist:
                                candidates.append(name)

    def analyze(self, file_path):
        """Analyze a Swift file and extract theme + UI structure."""
        if not os.path.exists(file_path):
            return {"error": "File not found"}

        with open(file_path, "rb") as f:
            source = f.read()

        tree = self.parser.parse(source)
        source_str = source.decode("utf-8")

        colors = self.extract_colors(source_str)
        fonts = self.extract_fonts(source_str)
        spacing = self.extract_spacing(source_str)
        shapes = self.extract_shapes(source_str)
        
        state_vars = self.extract_state_variables(source_str, 
                                                   theme_colors=set(colors.keys()), 
                                                   theme_fonts=set(fonts.keys()),
                                                   theme_spacing=set(spacing.keys()),
                                                   theme_shapes=set(shapes.keys()))

        all_views, view_builders = self.collect_view_bodies(tree.root_node, source)

        ui_tree = []

        entry_point = self.find_entry_point_from_window_group(tree.root_node, source)
        if entry_point and entry_point in all_views:
            leaf_view = self._find_leaf_view(entry_point, all_views, source)
            ui_tree = all_views[leaf_view]

        if not ui_tree and all_views:
            for view_name in reversed(list(all_views.keys())):
                if len(view_name) > 3:
                    ui_tree = all_views[view_name]
                    break

        if not ui_tree:
            ui_tree = self.find_ui_recursive(tree.root_node, source)
        
        if view_builders:
            ui_tree = self.expand_view_references(ui_tree, view_builders, source)

        return {
            "theme": {"colors": colors, "fonts": fonts},
            "ui_structure": ui_tree,
        }

    def _find_leaf_view(self, view_name, all_views, source):
        """Follow a View's body to find the ultimate leaf View it calls."""
        components = all_views.get(view_name, [])
        if len(components) == 1:
            potential_next = components[0].get("component")
            if potential_next in all_views and potential_next != view_name:
                return self._find_leaf_view(potential_next, all_views, source)
        return view_name


def save_analysis_to_file(analyzer, in_path, out_path):
    """Save analysis result to JSON file."""
    dir_name = os.path.dirname(out_path)
    if dir_name:
        os.makedirs(dir_name, exist_ok=True)
    result = analyzer.analyze(in_path)
    with open(out_path, "w", encoding="utf-8") as f:
        json.dump(result, f, indent=2, ensure_ascii=False)
    print(f"[tree_swift] {in_path} -> {out_path}")


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python tree_swift.py <in.swift|dir> [out.json|out_dir]")
        sys.exit(1)

    input_f = sys.argv[1]
    output_f = sys.argv[2] if len(sys.argv) > 2 else "nested_result.json"

    analyzer = SwiftUIExtractor()

    if os.path.isdir(input_f):
        # Process directory
        output_dir = output_f if len(sys.argv) > 2 else "nested_results"
        os.makedirs(output_dir, exist_ok=True)
        for root, _, files in os.walk(input_f):
            for file in files:
                if not file.endswith(".swift"):
                    continue
                in_file = os.path.join(root, file)
                rel = os.path.relpath(in_file, input_f)
                out_file = os.path.join(output_dir, f"{os.path.splitext(rel)[0]}.json")
                os.makedirs(os.path.dirname(out_file), exist_ok=True)
                save_analysis_to_file(analyzer, in_file, out_file)
        print(f"Done! Processed Swift directory {input_f} into {output_dir}")
    else:
        # Process single file
        save_analysis_to_file(analyzer, input_f, output_f)
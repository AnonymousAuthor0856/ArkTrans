#!/usr/bin/env python3
"""
RealCompilerInterface - ArkTS compiler integration based on real hvigor errors.

Two modes:
1. REAL MODE: If DEVECO_STUDIO_PATH or Hvigor_PATH is set,
   invokes the actual hvigor/ets compiler on a minimal project.
2. RULE MODE (default): Uses regex patterns extracted from real ArkTS
   compiler errors (arkts_rules.json + errors_cleaned.txt).

Usage:
    # Rule mode (default, no env vars needed)
    compiler = RealCompilerInterface()
    ok, errs = compiler.check(code)

    # Real compiler mode
    export DEVECO_STUDIO_PATH=/Applications/DevEco-Studio.app
    compiler = RealCompilerInterface()
    ok, errs = compiler.check(code)
"""

import os
import re
import shutil
import subprocess
import tempfile
from pathlib import Path
from typing import Dict, List, Tuple, Optional

class RealCompilerInterface:
    """
    Interface to check ArkTS code compilability.
    
    Uses real compiler error patterns extracted from hvigor build logs.
    If a real compiler path is configured, invokes it for authoritative checks.
    """
    
    def __init__(self):
        self.deveco_path = os.getenv("DEVECO_STUDIO_PATH", "")
        self.hvigor_path = os.getenv("Hvigor_PATH", "")
        self._real_compiler_cmd = self._discover_real_compiler()
        self.use_real_compiler = self._real_compiler_cmd is not None
        
        # Load real error patterns from arkts_rules.json if available
        self.rules = self._load_rules()
    
    def _discover_real_compiler(self) -> Optional[List[str]]:
        """
        Discover how to invoke the real ArkTS compiler.
        Returns a command list like ['node', '/path/to/hvigor', 'assembleHap']
        or None if no real compiler is available.
        
        Priority:
        1. Hvigor_PATH env var -> direct path to hvigor executable
        2. DEVECO_STUDIO_PATH -> look for bundled hvigor/node inside DevEco Studio
        3. System PATH -> npx hvigor (if globally installed)
        4. Project local -> ./hvigorw or ./hvigor/hvigorw.js
        """
        # 1. Direct Hvigor_PATH
        if self.hvigor_path:
            hvigor = Path(self.hvigor_path)
            if hvigor.exists():
                return [str(hvigor), "assembleHap"]
        
        # 2. DevEco Studio bundled toolchain
        if self.deveco_path:
            deveco = Path(self.deveco_path)
            candidates = [
                deveco / "Contents" / "tools" / "hvigor" / "bin" / "hvigor",
                deveco / "tools" / "hvigor" / "bin" / "hvigor",
                deveco / "Contents" / "MacOS" / "hvigor",
            ]
            for c in candidates:
                if c.exists():
                    return [str(c), "assembleHap"]
            node_candidates = [
                deveco / "Contents" / "tools" / "node" / "bin" / "node",
                deveco / "tools" / "node" / "bin" / "node",
            ]
            for node in node_candidates:
                if node.exists():
                    hvigor_js = node.parent.parent.parent / "hvigor" / "bin" / "hvigor.js"
                    if hvigor_js.exists():
                        return [str(node), str(hvigor_js), "assembleHap"]
        
        # 3. Check if hvigor is in PATH
        hvigor_in_path = shutil.which("hvigor")
        if hvigor_in_path:
            return [hvigor_in_path, "assembleHap"]
        
        # 4. Check for DevEco Command Line Tools
        cli_tools = Path.home() / "DevEco-Tools" / "bin" / "hvigorw"
        if cli_tools.exists():
            return [str(cli_tools), "assembleHap"]
        
        # 5. Check for project-local hvigorw in known template
        template = Path(__file__).parent.parent / "evaluate" / "minimal_hos"
        if template.exists():
            local_hvigor = template / "hvigorw"
            if local_hvigor.exists():
                return [str(local_hvigor), "assembleHap"]
            hvigor_js = template / "hvigor" / "hvigorw.js"
            if hvigor_js.exists():
                node = shutil.which("node")
                if node:
                    return [node, str(hvigor_js), "assembleHap"]
        
        return None
    
    def get_compiler_info(self) -> Dict:
        """Return info about current compiler configuration."""
        return {
            "mode": "real" if self.use_real_compiler else "rule-based",
            "command": self._real_compiler_cmd,
            "deveco_path": self.deveco_path,
            "hvigor_path": self.hvigor_path,
            "rules_loaded": len(self.rules),
        }
    
    def _load_rules(self) -> List[Dict]:
        """Load rules from arkts_rules.json if available."""
        rules_path = Path.home() / "Documents" / "MyWorkplace" / "arkts_trans" / "arkts_rules.json"
        if rules_path.exists():
            import json
            with open(rules_path, 'r', encoding='utf-8') as f:
                return json.load(f)
        return []
    
    def check(self, code: str) -> Tuple[bool, List[str]]:
        """
        Check if ArkTS code is compilable.
        Returns: (is_compilable, list_of_error_messages)
        """
        errors = []
        
        # === Structural Checks ===
        errors.extend(self._check_structure(code))
        
        # === Syntax Checks (based on real hvigor errors) ===
        errors.extend(self._check_syntax(code))
        
        # === Type Checks (ArkTS-specific) ===
        errors.extend(self._check_types(code))
        
        # === ArkUI Component Checks ===
        errors.extend(self._check_arkui(code))
        
        # === Import/Module Checks ===
        errors.extend(self._check_imports(code))
        
        # === Real compiler invocation (if configured) ===
        if self.use_real_compiler:
            real_errors = self._invoke_real_compiler(code)
            if real_errors:
                errors.extend(real_errors)
        
        is_compilable = len(errors) == 0
        return is_compilable, errors
    
    # Structure Checks
    def _check_structure(self, code: str) -> List[str]:
        errors = []
        
        if code.count('{') != code.count('}'):
            errors.append("[STRUCT] Brace mismatch")
        if code.count('(') != code.count(')'):
            errors.append("[STRUCT] Parenthesis mismatch")
        
        if '@Entry' not in code:
            errors.append("[STRUCT] Missing @Entry decorator")
        if '@Component' not in code:
            errors.append("[STRUCT] Missing @Component decorator")
        if 'build()' not in code:
            errors.append("[STRUCT] Missing build() method")
        
        return errors
    
    # Syntax Checks (based on real error code 10505001)
    def _check_syntax(self, code: str) -> List[str]:
        errors = []
        lines = code.split('\n')
        
        for i, line in enumerate(lines, 1):
            stripped = line.strip()
            if not stripped or stripped.startswith('//') or stripped.startswith('*'):
                continue
            
            # Dangling modifiers (e.g., `.height` without chaining)
            dangling_modifiers = re.findall(r'^\s*\.(\w+)\s*$', stripped)
            for mod in dangling_modifiers:
                if mod in ['height', 'width', 'padding', 'margin', 'backgroundColor', 
                           'fontSize', 'fontColor', 'borderRadius', 'aspectRatio']:
                    errors.append(f"[10505001] Line {i}: '{mod}' is a modifier method, "
                                  f"must be chained like `.{mod}(value)`.")
            
            # this.SomeComponent() calls outside build()
            match = re.match(r"^\s*this\.(\w+)\s*\(\s*\)\s*;?\s*$", stripped)
            if match:
                comp_name = match.group(1)
                if comp_name[0].isupper():
                    errors.append(f"[10905204] Line {i}: 'this.{comp_name}();' "
                                  f"does not meet UI component syntax. "
                                  f"Use a @Builder function or inline the component.")
            
            # `new` keyword (not allowed in ArkTS)
            if re.search(r'\bnew\s+\w+\s*\(', stripped):
                errors.append(f"[10505001] Line {i}: 'new' keyword is not allowed in ArkTS")
            
            # `console.log` (use `console.info` in ArkTS)
            if 'console.log(' in stripped:
                errors.append(f"[10505001] Line {i}: Use console.info() instead of console.log()")
        
        return errors
    
    # Type Checks (based on real error codes 10605038, 10605040, 10605008)
    def _check_types(self, code: str) -> List[str]:
        errors = []
        lines = code.split('\n')
        
        for i, line in enumerate(lines, 1):
            stripped = line.strip()
            
            # 10605038: Untyped object literals (but allow private field init)
            if re.search(r'^(const|let|var)\s+\w+\s*=\s*\{', stripped):
                if not re.search(r':\s*\w+\s*=\s*\{', stripped):
                    errors.append(f"[10605038] Line {i}: Untyped object literal. "
                                  f"Object literal must correspond to some explicitly "
                                  f"declared class or interface.")
            
            # 10605040: Object literals used as type declarations
            if re.search(r'^type\s+\w+\s*=\s*\{', stripped):
                errors.append(f"[10605040] Line {i}: Object literals cannot be used "
                              f"as type declarations.")
            
            # 10605043: Array literals with non-inferrable types
            if re.search(r'^(const|let|var)\s+\w+\s*=\s*\[', stripped):
                if not re.search(r':\s*\w+\[\]', stripped):
                    errors.append(f"[10605043] Line {i}: Array literal must have "
                                  f"explicitly declared element type.")
            
            # 10605008: Use of 'any' or 'unknown'
            if re.search(r':\s*any\b', stripped) or re.search(r':\s*unknown\b', stripped):
                errors.append(f"[10605008] Line {i}: Use explicit types instead of "
                              f"'any' or 'unknown'.")
            
            # 10605002: Use of 'var' (use 'let' or 'const')
            if re.search(r'\bvar\s+\w+\s*:', stripped):
                errors.append(f"[10605002] Line {i}: Use 'let' or 'const' instead of 'var'")
        
        return errors
    
    # ArkUI Component Checks (based on real error 10905204)
    def _check_arkui(self, code: str) -> List[str]:
        errors = []
        lines = code.split('\n')
        
        # Track nested container states: list of (type, depth) tuples
        stack = []
        
        for i, line in enumerate(lines, 1):
            stripped = line.strip()
            if not stripped or stripped.startswith('//'):
                continue
            
            open_braces = line.count('{')
            close_braces = line.count('}')
            
            # Detect container starts
            if re.search(r'\bList\s*\(', stripped):
                stack.append(('List', open_braces))
            elif re.search(r'\bListItem\s*\(', stripped):
                stack.append(('ListItem', open_braces))
            elif re.search(r'\bGrid\s*\(', stripped):
                stack.append(('Grid', open_braces))
            elif re.search(r'\bGridItem\s*\(', stripped):
                stack.append(('GridItem', open_braces))
            
            # Update depths and pop finished containers
            if close_braces > 0:
                net_change = close_braces - open_braces
                new_stack = []
                for container_type, depth in stack:
                    remaining = depth + net_change
                    if remaining > 0:
                        new_stack.append((container_type, remaining))
                stack = new_stack
            
            # Check for direct children in List without ListItem
            in_list = any(t == 'List' for t, _ in stack)
            in_listitem = any(t == 'ListItem' for t, _ in stack)
            if in_list and not in_listitem:
                if re.match(r'^\s*(Text|Button|Image|Row|Column|Divider|Slider|Progress|Stack|Grid|Blank)\s*\(', stripped):
                    errors.append(f"[10905204] Line {i}: List children must be "
                                  f"wrapped in ListItem(). Found direct child: {stripped[:40]}")
            
            # Check for direct children in Grid without GridItem
            in_grid = any(t == 'Grid' for t, _ in stack)
            in_griditem = any(t == 'GridItem' for t, _ in stack)
            if in_grid and not in_griditem:
                if re.match(r'^\s*(Text|Button|Image|Row|Column|Divider|Stack|List|Blank)\s*\(', stripped):
                    errors.append(f"[10905204] Line {i}: Grid children must be "
                                  f"wrapped in GridItem(). Found direct child: {stripped[:40]}")
        
        # Check for Blank() in illegal containers (Stack, Grid, List)
        # Blank() is only allowed inside Column() or Row()
        for i, line in enumerate(lines, 1):
            if 'Blank()' in line:
                nearest_container = None
                for j in range(i-1, max(0, i-15), -1):
                    m = re.search(r'(Column|Row|Stack|Grid|List)\s*\(', lines[j])
                    if m:
                        nearest_container = m.group(1)
                        break
                if nearest_container and nearest_container not in ('Column', 'Row'):
                    errors.append(f"[ARKUI] Line {i}: Blank() cannot be used inside "
                                  f"{nearest_container}. Use Column() or Row() instead.")
        
        return errors
    
    # Import/Module Checks (based on real error 10505001 module errors)
    def _check_imports(self, code: str) -> List[str]:
        errors = []
        
        invalid_imports = [
            (r"import\s+.*['\"]harmonyos['\"]", "'harmonyos' is not a valid module"),
            (r"import\s+.*['\"]@ohos\.arkui['\"]", "'@ohos.arkui' root namespace is auto-injected"),
            (r"import\s+.*['\"]@system\.", "'@system.*' modules are deprecated in ArkTS"),
        ]
        
        for pattern, msg in invalid_imports:
            if re.search(pattern, code):
                errors.append(f"[10505001] {msg}")
        
        return errors
    
    # Real Compiler Invocation
    def _invoke_real_compiler(self, code: str) -> List[str]:
        """
        Invoke real hvigor compiler by:
        1. Writing code to a temp project
        2. Running hvigor assembleHap or compileArkTS
        3. Parsing build log for errors

        Falls back silently to rule-based results if invocation fails.
        """
        errors = []

        if not self._real_compiler_cmd:
            return errors

        template = Path(__file__).parent.parent / "evaluate" / "minimal_hos"
        if not template.exists():
            return errors

        try:
            with tempfile.TemporaryDirectory() as tmpdir:
                project = Path(tmpdir) / "test_compile"
                shutil.copytree(template, project, dirs_exist_ok=True,
                                ignore=shutil.ignore_patterns('.idea', '.git', 'build', '.hvigor'))

                index_path = project / "entry" / "src" / "main" / "ets" / "pages" / "Index.ets"
                index_path.parent.mkdir(parents=True, exist_ok=True)
                with open(index_path, 'w', encoding='utf-8') as f:
                    f.write(code)

                cmd = list(self._real_compiler_cmd)
                # Note: compileArkTS task may not exist in all hvigor versions;
                # we use assembleHap directly for robustness.
                
                env = os.environ.copy()
                java_home = env.get("JAVA_HOME", "")
                env["JAVA_HOME"] = java_home
                env["PATH"] = f"{java_home}/bin:{env.get('PATH', '')}"

                result = subprocess.run(
                    cmd,
                    cwd=str(project),
                    capture_output=True,
                    text=True,
                    timeout=300,
                    env=env
                )

                if result.returncode != 0:
                    parsed = self._parse_hvigor_errors(result.stdout + result.stderr)
                    if parsed:
                        errors.extend(parsed)
                    else:
                        errors.append("[COMPILER] Real compiler failed (no parseable errors)")
        except subprocess.TimeoutExpired:
            errors.append("[COMPILER] Real compiler invocation timed out (>180s)")
        except Exception as e:
            errors.append(f"[COMPILER] Real compiler invocation failed: {e}")

        return errors

    def _parse_hvigor_errors(self, output: str) -> List[str]:
        """Parse hvigor build log for ArkTS compiler errors.

        Extracts structured errors with line numbers. Same error at different
        lines is kept separate. No deduping across error codes.
        """
        errors = []
        
        # Strip ANSI color codes
        ansi_re = re.compile(r'\x1b\[[0-9;]*m')
        output = ansi_re.sub('', output)
        
        # Extract structured ArkTS compiler errors
        arkts_blocks = re.findall(
            r'(\d+)\s*ERROR:\s*(\d+)\s*ArkTS\s*Compiler\s*Error\s*\n'
            r'Error\s*Message:\s*(.+?)At\s*File:\s*([^:]+):(\d+):(\d+)',
            output, re.DOTALL
        )
        for _, code, msg, filepath, line_no, col_no in arkts_blocks:
            clean_msg = ' '.join(msg.split())
            key = f"[{code}] Line {line_no}: {clean_msg}"
            errors.append(key)
        
        return errors

        """Parse hvigor build log for ArkTS compiler errors.
        Returns raw error messages without deduping or modification.
        """
        # Strip ANSI color codes only
        ansi_re = re.compile(r'\x1b\[[0-9;]*m')
        output = ansi_re.sub('', output)
        
        errors = []
        
        # Extract each ArkTS compiler error block as-is
        # Pattern: "N ERROR: XXXXXX ArkTS Compiler Error\nError Message: ..."
        blocks = re.findall(
            r'\d+\s*ERROR:\s*\d+\s*ArkTS\s*Compiler\s*Error\s*\n'
            r'(Error\s*Message:\s*.*?)(?=\n\s*(?:\d+\s*ERROR|COMPILE\s*RESULT|>\s*hvigor|$))',
            output, re.DOTALL
        )
        for block in blocks:
            # Keep the raw block, just normalize whitespace
            clean = ' '.join(block.split())
            errors.append(clean)
        
        return errors
        """Parse hvigor build log for ArkTS compiler errors.
        
        Extracts structured errors with line numbers. Same error at different
        lines is kept separate. No deduping across error codes.
        """
        errors = []
        seen = set()
        
        # Strip ANSI color codes
        ansi_re = re.compile(r'\x1b\[[0-9;]*m')
        output = ansi_re.sub('', output)
        
        # Extract structured ArkTS compiler errors
        # Pattern: "N ERROR: XXXXXX ArkTS Compiler Error\nError Message: ... At File: path:line:col"
        arkts_blocks = re.findall(
            r'(\d+)\s*ERROR:\s*(\d+)\s*ArkTS\s*Compiler\s*Error\s*\n'
            r'Error\s*Message:\s*(.+?)At\s*File:\s*([^:]+):(\d+):(\d+)',
            output, re.DOTALL
        )
        for _, code, msg, filepath, line_no, col_no in arkts_blocks:
            clean_msg = ' '.join(msg.split())
            key = f"[{code}] Line {line_no}: {clean_msg}"
            if key not in seen:
                seen.add(key)
                errors.append(key)
        
        return errors

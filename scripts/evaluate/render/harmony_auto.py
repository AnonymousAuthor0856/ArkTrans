"""HarmonyOS automation environment detection - locate DevEco Studio and derive everything from it.

Usage:
    from harmony_auto import detect_env
    env = detect_env()
    print(env.hvigorw, env.hdc, env.emulator_exe, env.phone_avd)
    """

import os
import sys
import time
import json
import shutil
import subprocess
import threading
from pathlib import Path
from dataclasses import dataclass, field
from typing import Optional, Union
import locale
import re

# Cross-process compile lock: when several experiment processes run in parallel they
# share the template project (same Index.ets writes / HAP deletes / build-profile
# edits), which corrupts without locking (PermissionError on .hap deletes,
# main_pages.json broken by concurrent builds). The file lock serializes only the
# shared writes inside build_hap; API calls still run in parallel.
try:
    import msvcrt
except ImportError:
    msvcrt = None

_compile_lock_file = None
_compile_thread_lock = threading.Lock()  # in-process fallback to avoid self-deadlock between threads

def _acquire_build_lock(timeout: float = 300.0):
    """Acquire the cross-process compile lock (blocking). None on failure."""
    global _compile_lock_file
    if msvcrt is None:
        return None
    lock_dir = _TEMPLATE_PROJECT.parent
    lock_dir.mkdir(parents=True, exist_ok=True)
    lock_path = lock_dir / ".build.lock"
    f = open(lock_path, "a+")
    deadline = time.time() + timeout
    while True:
        try:
            f.seek(0)
            msvcrt.locking(f.fileno(), msvcrt.LK_NBLCK, 1)
            _compile_lock_file = f
            return f
        except OSError:
            if time.time() > deadline:
                f.close()
                return None
            time.sleep(0.1)

def _release_build_lock(f):
    """Release the compile lock."""
    global _compile_lock_file
    if f is not None and msvcrt is not None:
        try:
            f.seek(0)
            msvcrt.locking(f.fileno(), msvcrt.LK_UNLCK, 1)
        except OSError:
            pass
        try:
            f.close()
        except OSError:
            pass
    if _compile_lock_file is f:
        _compile_lock_file = None


# -- platform detection ------------------------------------------------
_IS_WIN = sys.platform == "win32"
_IS_MAC = sys.platform == "darwin"
_IS_LINUX = sys.platform.startswith("linux")


def _exe(name: str) -> str:
    """Append .bat/.exe suffixes on Windows only."""
    if _IS_WIN:
        return name + ".bat" if "bat" in name or name in ("hvigorw", "ohpm") else name + ".exe"
    return name

def strip_ansi_colors(text: str) -> str:
    ansi_color = re.compile(r'\x1b\[[0-9;]*m')
    return ansi_color.sub('', text)


def extract_errors(log_text: str) -> str:
    """Extract error lines from a build log; return the log tail if no ERROR found."""
    if not log_text:
        return "(no output)"
    lines = log_text.splitlines()
    errors = []
    i = 0
    while i < len(lines):
        line = lines[i]
        if "ERROR" in line and "WARN" not in line:
            block = [line.strip()]
            i += 1
            while i < len(lines):
                nxt = lines[i].strip()
                if ("ERROR" in nxt and "WARN" not in nxt) or \
                   "WARN" in nxt or "COMPILE RESULT" in nxt or "* Try:" in nxt:
                    break
                block.append(nxt)
                i += 1
            errors.append("\n".join(block))
        else:
            i += 1
    if errors:
        return "\n---\n".join(errors)
    tail = [l for l in lines[-20:] if l.strip()]
    return "\n".join(tail) if tail else log_text[-500:]


# -- data structures ----------------------------------------------------

@dataclass
class AVD:
    name: str
    device_type: str       # phone / foldable / tablet / 2in1 / ...
    api_version: int       # 23
    os_version: str        # "HarmonyOS 6.1.0(23)"
    instance_path: str
    image_root: str
    is_running: bool = False


@dataclass
class HarmonyEnv:
    deveco_home: Optional[str] = None
    java_home: Optional[str] = None
    hvigorw: Optional[str] = None
    hdc: Optional[str] = None
    ohpm: Optional[str] = None
    emulator_exe: Optional[str] = None
    sdk_path: Optional[str] = None
    sdk_ets: Optional[str] = None
    arkuix_sdk: Optional[str] = None
    avds: list[AVD] = field(default_factory=list)

    @property
    def phone_avd(self) -> Optional[AVD]:
        for a in self.avds:
            if a.device_type == "phone":
                return a
        return self.avds[0] if self.avds else None

    @property
    def ready(self) -> bool:
        return all([self.deveco_home, self.hvigorw, self.hdc, self.emulator_exe, self.avds])

    def summary(self) -> str:
        lines = ["HarmonyEnv (all from DevEco Studio):"]
        lines.append(f"  DevEco  : {self.deveco_home or 'NOT FOUND'}")
        lines.append(f"  JAVA    : {self.java_home or '-'}")
        lines.append(f"  SDK     : {self.sdk_path or '-'}")
        lines.append(f"  ArkUI-X : {self.arkuix_sdk or 'not installed'}")
        lines.append(f"  hvigorw : {self.hvigorw or '-'}")
        lines.append(f"  ohpm    : {self.ohpm or '-'}")
        lines.append(f"  hdc     : {self.hdc or '-'}")
        lines.append(f"  Emulator: {self.emulator_exe or '-'}")
        lines.append(f"  AVDs ({len(self.avds)}):")
        for a in self.avds:
            lines.append(f"    - {a.name} ({a.device_type}, {a.os_version})")
        return "\n".join(lines)


def _get_windows_drives():
    """Return all available drive roots, e.g. ['C:\\', 'D:\\']."""
    import string
    from ctypes import windll
    drives = []
    bitmask = windll.kernel32.GetLogicalDrives()
    for letter in string.ascii_uppercase:
        if bitmask & 1:
            drives.append(f"{letter}:\\")
        bitmask >>= 1
    return drives


def find_folder(
    folder_name: str,
    parent_name: Optional[str] = None,
    search_depth: int = 6,
    timeout: int = 90,
    search_root: Union[Path, str, None] = None,
) -> Optional[Path]:
    """
    Cross-platform folder search.
    Windows -> PowerShell Get-ChildItem; macOS / Linux -> find.
    """
    roots: list[str] = []
    if search_root:
        r = str(Path(search_root).resolve())
        if not Path(r).is_dir():
            print(f"[WARN] search root does not exist: {r}")
            return None
        roots = [r]
        print(f"[INFO] searching for folder {folder_name} in {r} ...")
    elif _IS_WIN:
        roots = _get_windows_drives()
        if not roots:
            print("[WARN] no drives detected")
            return None
        print(f"[INFO] searching all drives for folder {folder_name} ...")
    else:
        roots = [str(Path.home())]

    start = time.time()

    if _IS_WIN:
        # PowerShell
        path_arg = ",".join([f"{d}\\" for d in roots])
        ps_cmd = (
            f"Get-ChildItem -Path {path_arg} -Directory -Filter '{folder_name}' "
            f"-Recurse -Depth {search_depth} -ErrorAction SilentlyContinue "
        )
        if parent_name:
            ps_cmd += f"| Where-Object {{ $_.Parent.Name -eq '{parent_name}' }} "
        ps_cmd += "| Select-Object -First 1 -ExpandProperty FullName"
        try:
            result = subprocess.run(
                ["powershell", "-NoProfile", "-Command", ps_cmd],
                capture_output=True, text=True, timeout=timeout,
            )
        except FileNotFoundError:
            print("[ERROR] PowerShell not available")
            return None
        except subprocess.TimeoutExpired:
            print(f"[WARN] search for {folder_name} timed out ({timeout}s), treating as not found")
            return None
    else:
        # macOS / Linux: find
        find_cmd = ["find"] + roots + [
            "-maxdepth", str(search_depth),
            "-type", "d", "-name", folder_name,
        ]
        if parent_name:
            find_cmd += ["-path", f"*/{parent_name}/{folder_name}"]
        find_cmd += ["-print", "-quit"]
        try:
            result = subprocess.run(find_cmd, capture_output=True, text=True, timeout=timeout)
        except FileNotFoundError:
            print("[ERROR] find command not available")
            return None

    elapsed = time.time() - start
    print(f"[INFO] search finished in {elapsed:.1f}s")

    candidate = result.stdout.strip()
    if candidate:
        p = Path(candidate.split("\n")[0])
        if p.is_dir():
            print(f"[INFO] folder found: {p}")
            return p
    if search_root:
        print(f"[WARN] folder {folder_name} not found under {search_root}")
    else:
        print(f"[WARN] folder not found: {folder_name}")
    return None

def detect_language():
    """Detect the system language; return 'cn' when the locale starts with 'zh', else 'en'."""
    lang = None

    # method 1: locale.getdefaultlocale() (cross-platform)
    try:
    
        lang = locale.getdefaultlocale()[0]
    except (ValueError, TypeError):
        pass

    # fall back to environment variables
    if not lang:
        lang = os.environ.get('LC_ALL') or os.environ.get('LANG') or os.environ.get('LANGUAGE')

    # default to English
    if not lang:
        return 'en'

    lang_code = lang.split('_')[0].split('.')[0].lower()


    return 'cn' if lang_code.startswith('zh') else 'en'

# -- detection (everything via DevEco) ----------------------------------

def _find_deveco_or_cli() -> tuple[Optional[Path], Optional[Path]]:
    """Return (deveco_root, cli_root); at least one is non-None."""
    deveco = cli = None

    if _IS_WIN:
        for d in [Path("C:/Program Files/Huawei/DevEco Studio"),
                  Path("D:/Program Files/Huawei/DevEco Studio")]:
            if d.is_dir():
                deveco = d; break
        for c in [Path("F:/command-line-tools"), Path("C:/command-line-tools")]:
            if (c / "bin" / "hvigorw.bat").is_file():
                cli = c; break
    elif _IS_MAC:
        candidates = [
            Path("/Applications/DevEco-Studio.app/Contents"),
            Path(os.path.expanduser("~/Applications/DevEco-Studio.app/Contents")),
        ]
        for d in candidates:
            if d.is_dir():
                deveco = d; break
    elif _IS_LINUX:
        for c in [Path(os.path.expanduser("~/command-line-tools")),
                  Path("/opt/command-line-tools")]:
            if (c / "bin" / "hvigorw").is_file() or (c / "bin" / "hvigorw.bat").is_file():
                cli = c; break

    if not deveco and not cli:
        found = find_folder("DevEco Studio")
        if found:
            deveco = found
    if not cli:
        for name in ["command-line-tools", "CommandLineTools"]:
            c = find_folder(name, search_depth=4, timeout=30)
            if c and ((c / "bin" / "hvigorw").is_file() or (c / "bin" / "hvigorw.bat").is_file()):
                cli = c; break

    return deveco, cli


def _find_arkuix(deveco: Optional[Path], cli: Optional[Path]) -> Optional[str]:
    """Locate the ArkUI-X SDK across platforms."""
    search_roots = []
    if _IS_WIN:
        for u in Path("C:/Users").iterdir():
            if u.is_dir():
                search_roots.append(str(u / "AppData" / "Local"))
    elif _IS_MAC:
        search_roots.append(str(Path.home() / "Library"))
    if deveco:
        search_roots.append(str(deveco / "sdk" / "default"))
    if cli:
        search_roots.append(str(cli / "sdk" / "default"))

    for sr in search_roots:
        f = find_folder("ArkUI-X", search_root=sr, search_depth=5, timeout=30)
        if f:
            return str(f)
    return None


def detect_env() -> HarmonyEnv:
    """
    Cross-platform HarmonyOS environment detection.
    Windows/macOS -> DevEco Studio; Linux -> Command Line Tools.
    """
    env = HarmonyEnv()
    deveco, cli = _find_deveco_or_cli()

    if not deveco and not cli:
        raise RuntimeError(
            "DevEco Studio or Command Line Tools not found. "
            f"Download: https://developer.huawei.com/consumer/{detect_language()}/download/"
        )

    # -- derive tool paths from DevEco or CLI --
    base = deveco or cli
    assert base

    env.deveco_home = str(deveco) if deveco else None

    # JBR (DevEco only)
    jbr = base / "jbr"
    if jbr.is_dir():
        env.java_home = str(jbr)

    # SDK
    sdk = base / "sdk"
    if sdk.is_dir():
        env.sdk_path = str(sdk)
        ets_base = sdk / "default" / "openharmony" / "ets"
        if ets_base.is_dir():
            versions = sorted([d for d in ets_base.iterdir() if d.is_dir()], reverse=True)
            env.sdk_ets = str(versions[0]) if versions else str(ets_base)

    # ArkUI-X
    env.arkuix_sdk = _find_arkuix(deveco, cli)

    # tools/ bundle
    tools = base / "tools"
    if tools.is_dir():
        hw = tools / "hvigor" / "bin" / _exe("hvigorw")
        if hw.is_file():
            env.hvigorw = str(hw)

        op = tools / "ohpm" / "bin" / _exe("ohpm")
        if op.is_file():
            env.ohpm = str(op)

        emu = tools / "emulator" / _exe("Emulator")
        if emu.is_file():
            env.emulator_exe = str(emu)

    # without DevEco tools, try the CLI bin
    if not env.hvigorw and cli:
        hw = cli / "bin" / _exe("hvigorw")
        if hw.is_file():
            env.hvigorw = str(hw)
        op = cli / "bin" / _exe("ohpm")
        if op.is_file():
            env.ohpm = str(op)
        emu = cli / "emulator" / _exe("Emulator")
        if emu.is_file():
            env.emulator_exe = str(emu)

    # hdc
    for loc in [base, cli] if cli else [base]:
        if not loc:
            continue
        hdc = loc / "sdk" / "default" / "openharmony" / "toolchains" / _exe("hdc")
        if hdc.is_file():
            env.hdc = str(hdc)
            break

    # AVD
    if env.emulator_exe:
        env.avds = _list_avds(env.emulator_exe)

    return env


def _list_avds(emulator_exe: str) -> list[AVD]:
    try:
        result = subprocess.run(
            [emulator_exe, "-list", "-details"],
            capture_output=True, text=True, timeout=15,
            encoding="utf-8", errors="replace",
        )
        if result.returncode != 0:
            return []
        avds = []
        for item in json.loads(result.stdout):
            avds.append(AVD(
                name=item.get("name", "?"),
                device_type=item.get("deviceType", "unknown"),
                api_version=int(item.get("os.apiVersion", "0") or "0"),
                os_version=item.get("os.osVersion", ""),
                instance_path=item.get("instancePath", ""),
                image_root=item.get("imageRoot", ""),
                is_running=item.get("isRunning", "false") == "true",
            ))
        return avds
    except Exception:
        return []


# -- dynamic AVD creation -----------------------------------------------

def ensure_avd(
    env: HarmonyEnv,
    os_version: str = "HarmonyOS 6.0.2(22)",
    width: int = 720,
    height: int = 1280,
    dpi: int = 320,
    diagonal: float = 4.65,
    device_type: str = "phone",
) -> AVD:
    """
    Ensure an AVD matching the parameters exists; download the image and create it if missing.

    Returns: the matching AVD object.
    """
    # 1. check whether an existing AVD matches
    for avd in env.avds:
        if avd.os_version == os_version and avd.device_type == device_type:
            try:
                result = subprocess.run(
                    [env.emulator_exe, "-list", "-details"],
                    capture_output=True, text=True, timeout=15,
                    encoding="utf-8", errors="replace",
                )
                for item in json.loads(result.stdout):
                    if item["name"] == avd.name:
                        h = item.get("hw.lcd.single.height", "")
                        w = item.get("hw.lcd.single.width", "")
                        d = item.get("hw.lcd.density", "")
                        if str(h) == str(height) and str(w) == str(width) and str(d) == str(dpi):
                            print(f"[AVD] matching device exists: {avd.name}")
                            return avd
            except Exception:
                pass

    # 2. check/download the image
    print(f"[AVD] checking image {os_version} {device_type} ...")
    images_raw = subprocess.run(
        [env.emulator_exe, "-imageList", "-deviceType", device_type],
        capture_output=True, text=True, timeout=20,
        encoding="utf-8", errors="replace",
    )
    downloaded = False
    try:
        for img in json.loads(images_raw.stdout):
            if img.get("osVersion") == os_version and img.get("downloaded") == "true":
                downloaded = True
                break
    except Exception:
        pass

    if not downloaded:
        raise RuntimeError(
            f"Image {os_version} ({device_type}) not downloaded.\n"
            f"Open DevEco Studio -> Device Manager and download the HarmonyOS {os_version} image\n"
            f"(CLI downloads risk timeouts; the GUI is recommended)."
        )

    # 3. create the AVD
    avd_name = f"Auto_{width}x{height}_{dpi}dpi"
    screen_cfg = f"{width} {height} {dpi} {diagonal}"
    print(f"[AVD] creating {avd_name}: {screen_cfg}")
    r = subprocess.run(
        [env.emulator_exe, "-create", avd_name,
         "-deviceType", device_type,
         "-osVersion", os_version,
         "-screen", screen_cfg],
        capture_output=True, text=True, timeout=120,
        encoding="utf-8", errors="replace",
    )
    if r.returncode != 0:
        raise RuntimeError(f"AVD creation failed: {r.stderr}")

    # 4. reload the AVD list
    env.avds = _list_avds(env.emulator_exe)
    for avd in env.avds:
        if avd.name == avd_name:
            return avd

    raise RuntimeError(f"AVD {avd_name} not found after creation")



# =======================================================================
# Automation pipeline: build -> emulator -> install -> screenshot
# =======================================================================

_TEMPLATE_PROJECT = Path(__file__).resolve().parents[1] / "etssingleui"
_INDEX_ETS = _TEMPLATE_PROJECT / "entry" / "src" / "main" / "ets" / "pages" / "Index.ets"


def _run(cmd: list[str], cwd=None, timeout=300, env_extra=None) -> subprocess.CompletedProcess:
    """Run a command inheriting the current env plus optional extras; 5-min default timeout."""
    run_env = os.environ.copy()
    if env_extra:
        run_env.update(env_extra)
    r=subprocess.run(cmd, cwd=cwd, capture_output=True, text=True,
                     encoding="utf-8", errors="replace",
                     timeout=timeout, env=run_env)
    r.stdout=strip_ansi_colors(str(r.stdout))
    r.stderr=strip_ansi_colors(str(r.stderr))
    return r


def _ensure_npm_registry():
    """Switch npm registry via nrm (best effort, cross-platform)."""
    import shutil
    nrm = shutil.which("nrm") or str(Path(os.environ.get("APPDATA", "")) / "npm" / "nrm.cmd")
    subprocess.run([nrm, "use", "harmonyos"], capture_output=True, timeout=10)


def _rmtree_retry(path: Path, attempts: int = 5, delay: float = 1.0) -> None:
    """Delete a directory with retries (java/daemons may briefly hold the copy after hvigor builds)."""
    for i in range(attempts):
        try:
            shutil.rmtree(path)
            return
        except OSError:
            if i == attempts - 1:
                print(f"[build] WARN: could not delete copy {path} (still held after {attempts} attempts)")
                return
            time.sleep(delay)


def _make_template_copy() -> Path:
    """Copy the template project to an isolated working copy and return its path.

    Excluded: .hvigor (build state with absolute paths), oh_modules (rebuildable
    dependencies), .arkui-x (platform cache), entry/build (build outputs).
    """
    global _TEMPLATE_PROJECT, _INDEX_ETS
    src = _TEMPLATE_PROJECT
    suffix = f"_{os.getpid()}_{threading.get_ident()}"
    dst = Path(src.parent) / f"etssingleui{suffix}"

    def _ignore(d: str, names: list[str]) -> list[str]:
        p = Path(d)
        skip = {".hvigor", "oh_modules", ".arkui-x"}
        if p == src / "entry":
            skip.add("build")
        return [n for n in names if n in skip]

    shutil.copytree(src, dst, ignore=_ignore)
    # point the globals at the copy
    _TEMPLATE_PROJECT = dst
    _INDEX_ETS = dst / "entry" / "src" / "main" / "ets" / "pages" / "Index.ets"
    return dst


def build_hap(env: HarmonyEnv, ets_code: str, daemon: bool = True,
              bundle_suffix: str = "") -> dict:
    """
    Compile ArkTS code into a .hap.

    bundle_suffix: optional suffix (e.g. "001") yielding a unique bundleName
                  "com.test.ui.001"; empty keeps the default "com.example.etssingleui".

    True parallelism: every process copies its own template copy (excluding
    .hvigor/oh_modules/.arkui-x state and entry/build outputs), builds inside it,
    and deletes it afterwards. Processes never share the template project, so both
    builds and API calls run in parallel. See _build_hap_impl for the PATH fixups
    (hvigor-spawned pnpm/node/java need DevEco's node and jbr on PATH).

    Returns: {"success": bool, "hap_path": str|None, "stdout": str, "stderr": str}
    """
    global _TEMPLATE_PROJECT, _INDEX_ETS
    with _compile_thread_lock:
        orig_template, orig_index = _TEMPLATE_PROJECT, _INDEX_ETS
        copy_dir = None
        try:
            copy_dir = _make_template_copy()
            result = _build_hap_impl(env, ets_code, daemon=False, bundle_suffix=bundle_suffix)
            if result["success"] and result["hap_path"]:
                src_hap = Path(result["hap_path"])
                persist_dir = orig_template / "entry" / "build" / "default" / "outputs" / "default"
                persist_dir.mkdir(parents=True, exist_ok=True)
                persist_hap = persist_dir / src_hap.name
                try:
                    shutil.copy2(src_hap, persist_hap)
                    result["hap_path"] = str(persist_hap)
                except OSError:
                    pass  # keep the in-copy path if persisting fails (rare)
            return result
        finally:
            _TEMPLATE_PROJECT, _INDEX_ETS = orig_template, orig_index
            if copy_dir and copy_dir.exists():
                _rmtree_retry(copy_dir)


def _build_hap_impl(env: HarmonyEnv, ets_code: str, daemon: bool = True,
                    bundle_suffix: str = "") -> dict:
    """
    Compile ArkTS code into a .hap (implementation, wrapped by build_hap's lock).

    bundle_suffix: optional suffix (e.g. "001") yielding a unique bundleName
                  "com.test.ui.001"; empty keeps the default "com.example.etssingleui".

    Returns: {"success": bool, "hap_path": str|None, "stdout": str, "stderr": str}
    """
    if not env.hvigorw or not env.arkuix_sdk:
        return {"success": False, "hap_path": None,
                "stdout": "", "stderr": "hvigorw or ArkUI-X SDK not found"}

    # 1. local.properties -> ArkUI-X SDK root (matches DevEco Studio's arkuix.sdk.location);
    #    path format: <root>/Sdk (not <root>/Sdk/<version>/arkui-x)
    arkuix_sdk_root = Path(env.arkuix_sdk) / "Sdk"
    arkuix_dir = str(arkuix_sdk_root)

    local_props = _TEMPLATE_PROJECT / "local.properties"
    local_props.write_text(f"arkui-x.dir={arkuix_dir.replace(chr(92), '/')}\n")

    # 2. npm registry
    _ensure_npm_registry()

    # 3. replace Index.ets + write verification
    _INDEX_ETS.parent.mkdir(parents=True, exist_ok=True)
    _INDEX_ETS.write_text(ets_code, encoding="utf-8")
    # force-refresh mtime (hvigor incremental builds rely on timestamps)
    os.utime(_INDEX_ETS, None)
    written = _INDEX_ETS.read_text(encoding="utf-8")
    first_line = written.strip().split("\n")[0][:80] if written.strip() else "(empty)"
    index_mtime = _INDEX_ETS.stat().st_mtime
    print(f"[build] Index.ets written: {first_line}...  ({len(written)} chars)  mtime={index_mtime:.0f}")

    # delete stale HAPs so a failed build cannot pass off an old package
    for old_hap in _TEMPLATE_PROJECT.glob("**/*.hap"):
        old_hap.unlink()
        print(f"[build] removed old HAP: {old_hap.name}")

    # 3.5 ohpm install
    if env.ohpm:
        _run([env.ohpm, "install"], cwd=_TEMPLATE_PROJECT, timeout=120)

    # 3.6 dynamically drop the ohosTest target (prevents the entry_test HAP shadowing entry)
    build_profile = _TEMPLATE_PROJECT / "entry" / "build-profile.json5"
    bp_original = build_profile.read_text(encoding="utf-8")
    bp_text = bp_original
    import re as _re
    bp_text = _re.sub(
        r'\{\s*"name"\s*:\s*"ohosTest"\s*,?\s*\}',
        '', bp_text,
    )
    # clean up leftover commas
    bp_text = _re.sub(r',\s*,', ',', bp_text)
    bp_text = _re.sub(r'\[\s*,', '[', bp_text)
    bp_text = _re.sub(r',\s*\]', ']', bp_text)
    build_profile.write_text(bp_text, encoding="utf-8")

    # 3.7 patch app.json5: bundleName + versionCode
    app_json5 = _TEMPLATE_PROJECT / "AppScope" / "app.json5"
    original_text = app_json5.read_text(encoding="utf-8")
    modified = original_text
    custom_bundle = ""
    if bundle_suffix:
        custom_bundle = f"com.test.ui.{bundle_suffix}"
        modified = _re.sub(
            r'"bundleName"\s*:\s*"[^"]*"',
            f'"bundleName": "{custom_bundle}"',
            modified,
        )
    # bump versionCode
    def _bump_vc(m):
        return f'"versionCode": {int(m.group(1)) + 1}'
    modified = _re.sub(r'"versionCode"\s*:\s*(\d+)', _bump_vc, modified)
    app_json5.write_text(modified, encoding="utf-8")
    try:
        # 4. build (kept-alive daemon speeds up batches; incremental, no clean)
        build_env = {
            "DEVECO_SDK_HOME": env.deveco_home or "",
            "ARKUIX_SDK_HOME": arkuix_dir or "",
            "JAVA_HOME": env.java_home or "",
        }
        # Root-cause fix: when hvigor spawns pnpm/node/java children and PATH lacks
        # DevEco's node and jbr, builds fail with "spawn ... ENOENT" / "pnpm install
        # execute failed (No stdout)". Prepend DevEco tools/node and jbr/bin to PATH.
        path_parts = []
        if env.deveco_home:
            path_parts.append(str(Path(env.deveco_home) / "tools" / "node"))
        if env.java_home:
            path_parts.append(str(Path(env.java_home) / "bin"))
        path_parts.append(os.environ.get("PATH", ""))
        build_env["PATH"] = os.pathsep.join(p for p in path_parts if p)

        result = _run(
            [env.hvigorw, "assembleHap",
             "--daemon" if daemon else "--no-daemon",
             "-p", "product=default", "-p", "buildMode=debug",
             "--parallel", "--incremental"],
            cwd=_TEMPLATE_PROJECT,
            env_extra=build_env,
        )
        print(f"[build] hvigor exit={result.returncode}")
        if result.returncode != 0:
            err_msg = result.stderr or result.stdout or "(no output)"
            print(f"[build] FAILED:\n{err_msg[-800:]}")
            return {
                "success": False, "hap_path": None,
                "stdout": result.stdout, "stderr": err_msg,
            }
    finally:
        app_json5.write_text(original_text, encoding="utf-8")
        build_profile.write_text(bp_original, encoding="utf-8")

    # 5. wait for the HAP (hvigor may write it asynchronously)
    deadline = time.time() + 120
    hap_path = None
    while time.time() < deadline:
        hap_candidates = sorted(
            _TEMPLATE_PROJECT.glob("**/*.hap"),
            key=lambda p: p.stat().st_mtime, reverse=True,
        )
        if hap_candidates:
            hap_path = str(hap_candidates[0])
            hap_mtime = Path(hap_path).stat().st_mtime
            if hap_mtime >= index_mtime:
                print(f"[build] HAP found: mtime={hap_mtime:.0f} size={Path(hap_path).stat().st_size}")
                break
        time.sleep(1)
    else:
        return {
            "success": False, "hap_path": None,
            "stdout": result.stdout,
            "stderr": "BUILD FAILED: No HAP generated within 120s after hvigor build.",
        }

    return {
        "success": True,
        "hap_path": hap_path,
        "bundle_name": custom_bundle or "com.example.etssingleui",
        "stdout": result.stdout,
        "stderr": result.stderr,
    }


def start_emulator(env: HarmonyEnv, avd_name: str = None) -> dict:
    """Start the emulator as a background process (non-blocking)."""
    name = avd_name or (env.phone_avd.name if env.phone_avd else "Pura 90")
    proc = subprocess.Popen(
        [env.emulator_exe, "-start", name],
        stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
    )
    # no wait - the emulator process keeps running
    return {"success": proc.poll() is None, "name": name,
            "pid": proc.pid, "stdout": "", "stderr": ""}


def wait_for_device(env: HarmonyEnv) -> bool:
    """
    HarmonyOS 6.0.2 emulator boot detection:
    1. hdc list targets finds the device;
    2. poll snapshot_display until it succeeds (a working screenshot = display
       system ready = lock screen shown).

    bootevent.* / dumpsys are unavailable on HarmonyOS 6 emulators;
    snapshot_display is the only reliable readiness signal.
    """
    print("[hdc] waiting for device...")
    while True:
        r = _run([env.hdc, "list", "targets"], timeout=10)
        if r.stdout.strip():
            print(f"[hdc] device found: {r.stdout.strip().split(chr(10))[0]}")
            break
        time.sleep(3)

    print("[hdc] waiting for display (snapshot_display)...")
    while True:
        r = _run([env.hdc, "shell", "snapshot_display",
                  "-f", "/data/local/tmp/_boot_check.jpeg"], timeout=20)
        if r.returncode == 0 and "success" in r.stdout.lower():
            print("[hdc] display ready!")
            return True
        print("[hdc] display not ready, retrying...")
        time.sleep(3)


def inspect_hap(hap_path: str) -> dict:
    """Pre-install HAP validation: parse module.json to confirm the entry module and ability."""
    import zipfile
    result = {"bundle_name": "", "module_name": "", "main_ability": "", "valid": False}
    try:
        with zipfile.ZipFile(hap_path, "r") as zf:
            for name in zf.namelist():
                if name.endswith("module.json") and "ohosTest" not in name:
                    data = json.loads(zf.read(name))
                    mod = data.get("module", {})
                    result["module_name"] = mod.get("name", "")
                    result["main_ability"] = mod.get("mainElement", "")
                    if result["module_name"] == "entry" and result["main_ability"]:
                        result["valid"] = True
                        print(f"[inspect] module={result['module_name']} mainElement={result['main_ability']}")
                    else:
                        print(f"[inspect] UNEXPECTED: module={result['module_name']} mainElement={result['main_ability']}")
                    break
    except Exception as e:
        print(f"[inspect] failed: {e}")
    return result


def install_and_launch(env: HarmonyEnv, hap_path: str,
                       bundle_name: str = "com.example.etssingleui",
                       ability_name: str = "EntryAbility") -> dict:
    """force-stop -> uninstall (verified) -> install (no -r) -> dump check -> launch -> wait for foreground."""
    import hashlib

    if not hap_path or not Path(hap_path).exists():
        return {"success": False, "stdout": "", "stderr": f"hap not found: {hap_path}"}

    hp = Path(hap_path)
    hap_md5 = hashlib.md5(hp.read_bytes()).hexdigest()
    print(f"[install] HAP: {str(hp.absolute())}")
    print(f"[install]  size={hp.stat().st_size}  mtime={hp.stat().st_mtime:.0f}  md5={hap_md5[:12]}")

    # 1. force-stop + wait for the process to die
    _run([env.hdc, "shell", "aa", "force-stop", bundle_name], timeout=10)
    time.sleep(2)

    # 2. uninstall + verify it is gone
    _run([env.hdc, "uninstall", bundle_name], timeout=15)
    time.sleep(2)
    # verify
    check = _run([env.hdc, "shell", "bm", "dump", "-n", bundle_name], timeout=10)
    if "bundleName" in check.stdout and "not found" not in check.stdout.lower():
        print(f"[install] WARN: bundle still present after uninstall, retrying...")
        _run([env.hdc, "uninstall", bundle_name], timeout=15)
        time.sleep(2)


    # 3. clean install
    r = _run([env.hdc, "install", str(hp.absolute())], timeout=60)
    if r.returncode != 0:
        return {"success": False, "stdout": r.stdout, "stderr": r.stderr}
    time.sleep(1)

    # 4. resolve the real entry from HAP contents (more reliable than bm dump, immune to entry_test)
    info = inspect_hap(hap_path)
    if info["main_ability"]:
        ability_name = info["main_ability"]

    # 4.5 bm dump confirmation
    dump = _run([env.hdc, "shell", "bm", "dump", "-n", bundle_name], timeout=15)
    for line in dump.stdout.split("\n"):
        if any(k in line for k in ("versionCode", "versionName")):
            print(f"[bm dump] {line.strip()}")

    # 4.6 inspect HAP contents: confirm the new UI code is packaged
    import zipfile
    ui_hints = []
    with zipfile.ZipFile(hap_path, "r") as zf:
        for name in sorted(zf.namelist()):
            if "ets" in name.lower() or "Index" in name:
                print(f"[hap content] {name}")
            # look for lines containing Text in ETS files
            if name.endswith(".ets") or name.endswith(".ts"):
                try:
                    content = zf.read(name).decode("utf-8", errors="replace")
                    for line in content.split("\n"):
                        if "Text" in line and len(line.strip()) > 3:
                            ui_hints.append(line.strip()[:120])
                except Exception:
                    pass
    if ui_hints:
        for h in ui_hints[:5]:
            print(f"[hap ui] {h}")

    # inspect modules.abc - the ArkTS build artifact (where the real UI code lives)
    try:
        with zipfile.ZipFile(hap_path, "r") as zf:
            abc_files = [n for n in zf.namelist() if n.endswith(".abc")]
            for abc_name in abc_files:
                abc_data = zf.read(abc_name)
                print(f"[hap abc] {abc_name} size={len(abc_data)}")
                # look for printable Text strings
                abc_text = abc_data.decode("utf-8", errors="replace")
                text_lines = [l for l in abc_text.split("\n")
                              if len(l.strip()) > 2 and len(l.strip()) < 200]
                if text_lines:
                    print(f"[hap abc] printable lines ({len(text_lines)}):")
                    for l in text_lines[:10]:
                        print(f"  {l.strip()[:120]}")
    except Exception as e:
        print(f"[hap abc] check failed: {e}")

    # 4.6 force-clear state after install
    _run([env.hdc, "shell", "aa", "force-stop", bundle_name], timeout=10)
    _run([env.hdc, "shell", "bm", "clean", "-c", "-d", "-n", bundle_name], timeout=10)

    # 4.7 pre-start diagnostics: check for leftover abilities
    pre_dump = _run([env.hdc, "shell", "aa", "dump", "-l"], timeout=15)
    if bundle_name in pre_dump.stdout:
        print(f"[pre-start] WARNING: {bundle_name} still in mission list before start!")
        print(pre_dump.stdout[:500])

    # 5. launch
    r2 = _run([env.hdc, "shell", "aa", "start", "-a", ability_name,
                "-b", bundle_name], timeout=30)
    if r2.returncode != 0:
        return {"success": False, "stdout": r.stdout, "stderr": r.stderr}

    # 6. wait for the page to render (uitest dumpLayout writes a file on-device;
    #    read it back to verify the hierarchy). Fail fast: check for process crash
    #    every loop and return immediately with logs instead of waiting out the timeout.
    print(f"[hdc] waiting for page render ({bundle_name})...")
    render_deadline = time.time() + 8
    last_stderr = ""
    rendered = False
    missing_prev = 0
    while time.time() < render_deadline:
        # crash detection: the bundle process must be absent in 2 consecutive
        # samples to count as crashed (during cold start or under load the process
        # may briefly vanish from ps; a single sample gives false crashes)
        proc_check = _run([env.hdc, "shell", "ps", "-ef"], timeout=10)
        if bundle_name not in proc_check.stdout:
            missing_prev = missing_prev + 1
        else:
            missing_prev = 0
        if missing_prev >= 2:
            log_path = fetch_logs(env, bundle_name)
            crash_detail = _read_log_tail(log_path)
            crash_js = _fetch_crash_detail(env, bundle_name)
            print(f"[hdc] CRASH detected (process gone). Logs saved to {log_path}")
            return {"success": False, "stdout": "",
                    "stderr": f"App process exited (crash) during render.\n"
                              f"=== JS crash ===\n{crash_js}\n"
                              f"=== hilog ===\n{crash_detail}"}

        _run([env.hdc, "shell", "uitest", "dumpLayout"], timeout=15)
        r3 = _run([env.hdc, "shell",
                    "ls -t /data/local/tmp/layout_*.json 2>/dev/null | head -1 | xargs cat"], timeout=10)
        if bundle_name in r3.stdout and "pagePath" in r3.stdout:
            try:
                raw = r3.stdout
                json_start = raw.index("{")
                layout = json.loads(raw[json_start:])
                def _depth(node, d=0):
                    return max([_depth(c, d+1) for c in node.get("children", [])] + [d])
                max_d = _depth(layout)
                if max_d >= 3:
                    print(f"[hdc] page rendered! depth={max_d}")
                    rendered = True
                    break
            except Exception:
                pass
        time.sleep(1)

    if not rendered:
        log_path = fetch_logs(env, bundle_name)
        render_detail = _read_log_tail(log_path)
        print(f"[hdc] FAILED waiting for render. Logs saved to {log_path}")
        return {"success": False, "stdout": "",
                "stderr": f"Page did not render within 8s.\n=== hilog ===\n{render_detail}"}

    return {"success": True, "stdout": r.stdout + "\n" + r2.stdout,
            "stderr": r.stderr + "\n" + r2.stderr}


def _read_log_tail(log_path: str, max_lines: int = 60) -> str:
    """Read the tail of a hilog file to attach crash/render-failure detail to stderr."""
    try:
        with open(log_path, encoding="utf-8", errors="replace") as f:
            lines = f.read().split("\n")
        return "\n".join(lines[-max_lines:])
    except OSError:
        return f"(cannot read log {log_path})"


def _fetch_crash_detail(env: HarmonyEnv, bundle_name: str) -> str:
    """Fetch the bundle's latest jscrash file from device faultlog (real JS error + stack)."""
    try:
        ls = _run([env.hdc, "shell", "ls", "-t", "/data/log/faultlog/faultlogger/"], timeout=10)
        crash_file = next(
            (l.strip() for l in ls.stdout.split("\n")
             if bundle_name in l and "jscrash" in l),
            None,
        )
        if not crash_file:
            return "(no jscrash file for this bundle in device faultlog)"
        cat = _run([env.hdc, "shell", "cat", f"/data/log/faultlog/faultlogger/{crash_file}"], timeout=10)
        # keep only the key sections: Reason/Error/Stacktrace and a few lines
        lines = cat.stdout.split("\n")
        out = []
        for i, l in enumerate(lines):
            if any(k in l for k in ("Reason:", "Error name:", "Error message:", "Stacktrace:", "    at ")):
                out.append(l)
        return "\n".join(out) if out else cat.stdout[:1500]
    except Exception as e:
        return f"(failed to fetch jscrash: {e})"


def fetch_logs(env: HarmonyEnv, bundle_name: str, output_path: str = None) -> str:
    """Pull hilog and filter lines related to the bundle."""
    dest = output_path or str(Path.cwd() / "hilog.txt")
    try:
        # hilog -x: read the buffer then exit (without -x it streams and hangs until TimeoutExpired)
        r = _run([env.hdc, "shell", "hilog", "-x"], timeout=15)
    except subprocess.TimeoutExpired:
        return dest
    lines = r.stdout.split("\n")
    filtered = [l for l in lines if bundle_name.lower() in l.lower() or "entryability" in l.lower()]
    output = "\n".join(filtered) if filtered else r.stdout[-3000:]
    Path(dest).write_text(output, encoding="utf-8", errors="replace")
    print(f"[hilog] {len(filtered)} lines matching {bundle_name}, saved to {dest}")
    return dest


def screenshot(env: HarmonyEnv, output_path: str = None) -> str:
    """Take a screenshot, pull it locally, and return its path."""
    dest = output_path or str(Path.cwd() / "screenshot.jpeg")
    _run([env.hdc, "shell", "snapshot_display", "-f", "/data/local/tmp/_ss.jpeg"], timeout=15)
    _run([env.hdc, "file", "recv", "/data/local/tmp/_ss.jpeg", dest], timeout=15)
    return dest


def stop_hvigor_daemon(env: HarmonyEnv):
    """Call after batch builds to stop hvigor daemons."""
    _run([env.hvigorw, "--stop-daemon"], cwd=_TEMPLATE_PROJECT, timeout=15)


def stop_emulator(env: HarmonyEnv, avd_name: str = None) -> dict:
    """Stop the emulator."""
    name = avd_name or "Pura 90"
    result = _run([env.emulator_exe, "-stop", name], timeout=20)
    return {"success": result.returncode == 0, "stdout": result.stdout, "stderr": result.stderr}


# -- one-key pipeline ----------------------------------------------------

def run_pipeline(ets_code: str, avd_name: str = None,
                 screenshot_path: str = None) -> dict:
    """
    One key: build -> start emulator -> install -> screenshot.

    Returns: {"success": bool, "screenshot": str|None, "hap_path": str|None,
              "build": ..., "error": str|None}
    """
    env = detect_env()
    if not env.ready:
        return {"success": False, "screenshot": None, "hap_path": None,
                "error": "HarmonyOS environment not ready"}

    avd = avd_name or (env.phone_avd.name if env.phone_avd else None)
    if not avd:
        return {"success": False, "screenshot": None, "hap_path": None,
                "error": "No AVD available"}

    print("\n[Pipeline] Step 1/4: Building HAP...")
    build = build_hap(env, ets_code)
    if not build["success"]:
        return {"success": False, "screenshot": None, "hap_path": None,
                "error": f"Build failed:\n{build['stderr']}", "build": build}

    print(f"\n[Pipeline] Step 2/4: Starting emulator ({avd})...")
    start_emulator(env, avd)

    print("[Pipeline] Waiting for device...")
    if not wait_for_device(env):
        return {"success": False, "screenshot": None, "hap_path": build["hap_path"],
                "error": "Emulator did not become ready", "build": build}

    print(f"\n[Pipeline] Step 3/4: Installing {build['hap_path']}...")
    install = install_and_launch(env, build["hap_path"])
    if not install["success"]:
        return {"success": False, "screenshot": None, "hap_path": build["hap_path"],
                "error": f"Install failed:\n{install['stderr']}",
                "build": build, "install": install}

    print(f"\n[Pipeline] Step 4/4: Taking screenshot...")
    ss = screenshot(env, screenshot_path)
    print(f"[Pipeline] Screenshot saved: {ss}")

    return {"success": True, "screenshot": ss, "hap_path": build["hap_path"],
            "build": build, "install": install, "error": None}

def compile(ets_code: str, env: HarmonyEnv = None, daemon: bool = True):
    """
    Convenience compile wrapper.
    daemon=True: use the daemon (batch scenarios; faster but call stop_hvigor_daemon at the end).
    daemon=False: no daemon (single call; exits cleanly with no background processes).
    """
    if env is None:
        env = detect_env()
    return build_hap(env, ets_code, daemon=daemon)


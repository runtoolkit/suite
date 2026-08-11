"""
_dp_common.py — Shared constants and .depends/ I/O for dp-depman tools.
Imported by dp-resolve.py, depend_remover.py, depend_edit.py.
"""

import json
import sys
from pathlib import Path

# ─── File layout ──────────────────────────────────────────────────────────────

DEPENDS_DIR      = Path(".depends")          # dependency declarations live here
CONFIG_FILE      = "datapack_depends.json"   # legacy / fallback
LOCK_FILE        = "datapack_depends.lock"
MANIFEST_FILE    = "manifest.json"           # pack's own identity inside .depends/
CACHE_DIR        = Path(".dp-cache")
OUTPUT_DIR       = Path("dist")
SUBMODULE_DIR    = Path("deps")

# ─── .depends/ layout ─────────────────────────────────────────────────────────
#
#   .depends/
#   ├── manifest.json          ← this pack's identity (id, version, description)
#   └── <dep_id>.json          ← one file per declared dependency
#
# manifest.json schema:
#   { "id": "examplePack", "version": "1.0.0", "description": "..." }
#
# <dep_id>.json schema (e.g. dataLib.json):
#   {
#     "source":  "github" | "submodule",
#     "repo":    "runtoolkit/dataLib",      ← github only
#     "url":     "https://github.com/...",  ← submodule only
#     "path":    "deps/dataLib",            ← submodule only (optional)
#     "version": ">=6.0.0",
#     "asset":   "dataLib-full.zip"         ← github only, optional
#   }

# ─── I/O helpers ──────────────────────────────────────────────────────────────

def load_manifest(root: Path) -> dict:
    """Load .depends/manifest.json. Falls back to datapack_depends.json fields."""
    dep_manifest = root / DEPENDS_DIR / MANIFEST_FILE
    if dep_manifest.exists():
        data = _read_json(dep_manifest)
        for field in ("id", "version"):
            if field not in data:
                die(f"manifest.json missing required field: '{field}'")
        return data

    # Fallback: legacy datapack_depends.json
    legacy = root / CONFIG_FILE
    if legacy.exists():
        data = _read_json(legacy)
        # Extract only identity fields
        return {
            "id":          data.get("id", "unknown"),
            "version":     data.get("version", "0.0.0"),
            "description": data.get("description", ""),
        }

    die(
        f"No manifest found. Create .depends/manifest.json or {CONFIG_FILE}.\n"
        f"  Minimum manifest.json: {{\"id\": \"my-pack\", \"version\": \"1.0.0\"}}"
    )

def load_all_deps(root: Path) -> dict[str, dict]:
    """
    Load all dependency declarations from .depends/<dep_id>.json files.
    Falls back to datapack_depends.json 'dependencies' block.
    Returns {dep_id: dep_cfg} dict.
    """
    dep_dir = root / DEPENDS_DIR
    if dep_dir.exists():
        deps = {}
        for f in sorted(dep_dir.glob("*.json")):
            if f.name == MANIFEST_FILE:
                continue
            dep_id = f.stem
            deps[dep_id] = _read_json(f)
        return deps

    # Fallback: legacy datapack_depends.json
    legacy = root / CONFIG_FILE
    if legacy.exists():
        data = _read_json(legacy)
        return data.get("dependencies", {})

    return {}

def load_dep(root: Path, dep_id: str) -> dict | None:
    """Load a single dependency file. Returns None if not found."""
    path = root / DEPENDS_DIR / f"{dep_id}.json"
    if path.exists():
        return _read_json(path)
    # Fallback
    deps = load_all_deps(root)
    return deps.get(dep_id)

def save_dep(root: Path, dep_id: str, dep_cfg: dict):
    """Write a single dependency file to .depends/<dep_id>.json."""
    dep_dir = root / DEPENDS_DIR
    dep_dir.mkdir(parents=True, exist_ok=True)
    path = dep_dir / f"{dep_id}.json"
    _write_json(path, dep_cfg)

def delete_dep(root: Path, dep_id: str) -> bool:
    """Delete .depends/<dep_id>.json. Returns True if deleted, False if not found."""
    path = root / DEPENDS_DIR / f"{dep_id}.json"
    if path.exists():
        path.unlink()
        return True
    return False

def save_manifest(root: Path, manifest: dict):
    dep_dir = root / DEPENDS_DIR
    dep_dir.mkdir(parents=True, exist_ok=True)
    _write_json(dep_dir / MANIFEST_FILE, manifest)

def load_lock(root: Path) -> dict:
    lock_path = root / LOCK_FILE
    if lock_path.exists():
        return _read_json(lock_path)
    return {"resolved": {}}

def save_lock(root: Path, lock: dict):
    lock_path = root / LOCK_FILE
    _write_json(lock_path, lock)

# ─── JSON helpers ─────────────────────────────────────────────────────────────

def _read_json(path: Path) -> dict:
    try:
        with open(path) as f:
            return json.load(f)
    except json.JSONDecodeError as e:
        die(f"JSON parse error in {path}: {e}")

def _write_json(path: Path, data: dict):
    with open(path, "w") as f:
        json.dump(data, f, indent=2)
        f.write("\n")

# ─── Logging ──────────────────────────────────────────────────────────────────

def log(msg: str):  print(f"[dp] {msg}")
def warn(msg: str): print(f"[dp] WARNING: {msg}", file=sys.stderr)
def die(msg: str):  print(f"[dp] ERROR: {msg}", file=sys.stderr); sys.exit(1)

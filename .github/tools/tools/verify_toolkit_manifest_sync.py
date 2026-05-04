#!/usr/bin/env python3
"""
Ensure docs/assets/toolkit-manifest.json matches build_toolkit_manifest output.

Compares canonical JSON with the `generated` timestamp omitted so CI does not
require rewriting the file on every run.
"""

from __future__ import annotations

import importlib.util
import json
import sys
from copy import deepcopy
from pathlib import Path

_REPO_ROOT = Path(__file__).resolve().parent.parent.parent.parent
_COMMITTED = _REPO_ROOT / "docs" / "assets" / "toolkit-manifest.json"


def _load_build_module():
    path = _REPO_ROOT / ".github" / "tools" / "tools" / "build_toolkit_manifest.py"
    spec = importlib.util.spec_from_file_location("build_toolkit_manifest", path)
    if spec is None or spec.loader is None:
        raise RuntimeError(f"Cannot load {path}")
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


def _without_generated(data: dict) -> dict:
    out = deepcopy(data)
    out.pop("generated", None)
    return out


def _canonical(data: dict) -> str:
    return json.dumps(data, sort_keys=True, ensure_ascii=False, indent=2)


def main() -> int:
    if not _COMMITTED.is_file():
        print(f"ERROR: Missing {_COMMITTED}", file=sys.stderr)
        return 1

    build = _load_build_module()
    committed = json.loads(_COMMITTED.read_text(encoding="utf-8"))
    fresh = build.get_manifest_data(_REPO_ROOT)

    a = _without_generated(committed)
    b = _without_generated(fresh)
    if _canonical(a) != _canonical(b):
        print(
            "ERROR: docs/assets/toolkit-manifest.json is out of sync with "
            ".github/tools/tools/build_toolkit_manifest.py (ignoring 'generated').\n"
            "Run: python3 .github/tools/tools/build_toolkit_manifest.py\n"
            "Then commit the updated manifest.",
            file=sys.stderr,
        )
        return 1

    print("Toolkit manifest is in sync with build_toolkit_manifest.py (generated ignored).")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())

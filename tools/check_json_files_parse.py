#!/usr/bin/env python3
"""Parse JSON schema and sample files; exit non-zero on failure."""

from __future__ import annotations

import json
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent

RELATIVE_JSON_FILES = (
    "schemas/ai-system-inventory.schema.json",
    "schemas/risk-screening.schema.json",
    "schemas/vendor-review.schema.json",
    "schemas/toolkit-registry.document.schema.json",
    "schemas/official-sources.document.schema.json",
    "schemas/use-cases.document.schema.json",
    "schemas/samples/ai-system-inventory.sample.json",
    "schemas/samples/risk-screening.sample.json",
    "schemas/samples/vendor-review.sample.json",
)


def main() -> int:
    errors = 0
    for rel in RELATIVE_JSON_FILES:
        path = REPO_ROOT / rel
        try:
            text = path.read_text(encoding="utf-8")
            json.loads(text)
            print(f"OK: {rel}")
        except FileNotFoundError:
            print(f"ERROR: missing {rel}", file=sys.stderr)
            errors += 1
        except json.JSONDecodeError as exc:
            print(f"ERROR: invalid JSON {rel}: {exc}", file=sys.stderr)
            errors += 1
    return 1 if errors else 0


if __name__ == "__main__":
    raise SystemExit(main())

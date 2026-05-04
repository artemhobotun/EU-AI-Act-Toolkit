#!/usr/bin/env python3
"""Validate minimal JSON samples against instance JSON Schemas in registry/schemas/."""

from __future__ import annotations

import json
import sys
from pathlib import Path

from jsonschema import Draft202012Validator

ROOT = Path(__file__).resolve().parent.parent.parent

PAIRS: tuple[tuple[str, str], ...] = (
    ("registry/schemas/samples/ai-system-inventory.sample.json", "registry/schemas/ai-system-inventory.schema.json"),
    ("registry/schemas/samples/risk-screening.sample.json", "registry/schemas/risk-screening.schema.json"),
    ("registry/schemas/samples/vendor-review.sample.json", "registry/schemas/vendor-review.schema.json"),
)


def main() -> int:
    errors = 0
    for sample_rel, schema_rel in PAIRS:
        sample_path = ROOT / sample_rel
        schema_path = ROOT / schema_rel
        try:
            schema = json.loads(schema_path.read_text(encoding="utf-8"))
            instance = json.loads(sample_path.read_text(encoding="utf-8"))
            validator = Draft202012Validator(schema)
            violations = sorted(validator.iter_errors(instance), key=lambda e: e.path)
            if violations:
                print(f"ERROR: {sample_rel} failed {schema_rel}:", file=sys.stderr)
                for err in violations:
                    path_str = "/".join(str(p) for p in err.absolute_path) or "(root)"
                    print(f"  at {path_str}: {err.message}", file=sys.stderr)
                errors += 1
            else:
                print(f"OK: {sample_rel}")
        except (OSError, json.JSONDecodeError) as exc:
            print(f"ERROR: {sample_rel}: {exc}", file=sys.stderr)
            errors += 1
    if errors:
        print(f"Schema sample validation failed ({errors} file(s)).", file=sys.stderr)
        return 1
    print("Schema sample validation passed.")
    return 0


if __name__ == "__main__":
    sys.exit(main())

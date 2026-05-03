#!/usr/bin/env python3
"""Validate data/*.yml registry files against JSON Schema document schemas."""

from __future__ import annotations

import json
import sys
from datetime import date, datetime
from pathlib import Path

import yaml
from jsonschema import Draft202012Validator

ROOT = Path(__file__).resolve().parent.parent


def _normalize_for_jsonschema(obj: object) -> object:
    """Coerce PyYAML types (e.g. dates) to JSON-compatible values for jsonschema."""
    if isinstance(obj, dict):
        return {str(k): _normalize_for_jsonschema(v) for k, v in obj.items()}
    if isinstance(obj, list):
        return [_normalize_for_jsonschema(x) for x in obj]
    if isinstance(obj, datetime):
        return obj.date().isoformat()
    if isinstance(obj, date):
        return obj.isoformat()
    return obj

REGISTRY_PAIRS: tuple[tuple[str, str], ...] = (
    ("data/toolkit-registry.yml", "schemas/toolkit-registry.document.schema.json"),
    ("data/official-sources.yml", "schemas/official-sources.document.schema.json"),
    ("data/use-cases.yml", "schemas/use-cases.document.schema.json"),
)


def _load_schema(path: Path) -> dict:
    with path.open(encoding="utf-8") as f:
        return json.load(f)


def _load_yaml(path: Path) -> object:
    with path.open(encoding="utf-8") as f:
        return yaml.safe_load(f)


def main() -> int:
    errors = 0
    for yml_rel, schema_rel in REGISTRY_PAIRS:
        yml_path = ROOT / yml_rel
        schema_path = ROOT / schema_rel
        if not yml_path.is_file():
            print(f"ERROR: missing YAML file: {yml_rel}", file=sys.stderr)
            errors += 1
            continue
        if not schema_path.is_file():
            print(f"ERROR: missing schema file: {schema_rel}", file=sys.stderr)
            errors += 1
            continue
        try:
            schema = _load_schema(schema_path)
            raw = _load_yaml(yml_path)
            if raw is None:
                print(f"ERROR: {yml_rel} parsed to null (empty file?)", file=sys.stderr)
                errors += 1
                continue
            instance = _normalize_for_jsonschema(raw)
            validator = Draft202012Validator(schema)
            violations = sorted(validator.iter_errors(instance), key=lambda e: e.path)
            if violations:
                print(f"ERROR: {yml_rel} failed {schema_rel}:", file=sys.stderr)
                for err in violations:
                    path_str = "/".join(str(p) for p in err.absolute_path) or "(root)"
                    print(f"  at {path_str}: {err.message}", file=sys.stderr)
                errors += 1
            else:
                print(f"OK: {yml_rel}")
        except (yaml.YAMLError, json.JSONDecodeError) as exc:
            print(f"ERROR: {yml_rel}: {exc}", file=sys.stderr)
            errors += 1
    if errors:
        print(f"Data registry validation failed ({errors} file(s)).", file=sys.stderr)
        return 1
    print("Data registry validation passed.")
    return 0


if __name__ == "__main__":
    sys.exit(main())

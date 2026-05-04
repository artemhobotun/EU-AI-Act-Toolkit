#!/usr/bin/env python3
"""
Generate a toolkit manifest with key metadata.

Creates a JSON manifest file (docs/assets/toolkit-manifest.json) containing
information about the toolkit structure, key pages, resources, and build info.
"""

import json
import sys
from pathlib import Path
from datetime import datetime, timezone


def get_repo_root():
    """Get the path to the repository root."""
    return Path(__file__).resolve().parent.parent.parent.parent


def read_version(repo_root: Path) -> str:
    """Single-line semver from .github/tools/dev/VERSION (keeps repo root listing short)."""
    path = repo_root / "maint" / "dev" / "VERSION"
    if not path.is_file():
        return "0.0.0"
    text = path.read_text(encoding="utf-8").strip()
    return text.splitlines()[0].strip() if text else "0.0.0"


def get_manifest_data(repo_root):
    """Build the manifest data structure."""
    return {
        "title": "EU AI Act Toolkit",
        "version": read_version(repo_root),
        "description": "Practical AI governance readiness for SMEs",
        "repository": {
            "url": "https://github.com/artemhobotun/EU-AI-Act-Toolkit",
            "type": "public"
        },
        "site": {
            "url": "https://artemhobotun.github.io/EU-AI-Act-Toolkit/",
            "type": "GitHub Pages"
        },
        "maintainer": {
            "name": "Artem Nazarko",
            "role": "Legal professional, researcher, legal-tech builder"
        },
        "pages": {
            "index": "index.html",
            "packs": "packs.html",
            "use_cases": "use-cases.html",
            "resources": "resources.html",
            "quiz": "quiz.html",
            "official_sources": "official-sources.html",
            "maintainer": "maintainer.html",
            "community": "community.html"
        },
        "toolkit_packs": [
            {
                "name": "Starter Pack",
                "description": "Foundation for AI governance readiness",
                "path": "toolkit/starter-pack/"
            },
            {
                "name": "Vendor Assessment Pack",
                "description": "Evaluate AI-enabled SaaS tools",
                "path": "toolkit/vendor-pack/"
            },
            {
                "name": "Sector Packs",
                "description": "Context-specific guidance for 6 sectors",
                "path": "toolkit/sector-packs/"
            },
            {
                "name": "Templates",
                "description": "Ready-to-use governance documents",
                "path": "toolkit/templates/"
            },
            {
                "name": "Checklists",
                "description": "Readiness and assessment checklists",
                "path": "toolkit/checklists/"
            }
        ],
        "official_sources": [
            {
                "title": "Regulation (EU) 2024/1689",
                "url": "https://eur-lex.europa.eu/eli/reg/2024/1689/oj",
                "type": "regulation"
            },
            {
                "title": "European Commission AI Regulatory Framework",
                "url": "https://digital-strategy.ec.europa.eu/en/policies/regulatory-framework-ai",
                "type": "policy"
            },
            {
                "title": "EU AI Office",
                "url": "https://digital-strategy.ec.europa.eu/en/policies/ai-office",
                "type": "agency"
            }
        ],
        "generated": datetime.now(timezone.utc).isoformat().replace("+00:00", "Z"),
        "license": "CC0 1.0 Universal (Public Domain Dedication)"
    }


def write_manifest(repo_root, manifest_data):
    """Write manifest to JSON file."""
    output_path = repo_root / 'docs' / 'assets' / 'toolkit-manifest.json'

    output_path.parent.mkdir(parents=True, exist_ok=True)

    with open(output_path, 'w', encoding='utf-8') as f:
        json.dump(manifest_data, f, indent=2, ensure_ascii=False)

    return output_path


def main():
    """Generate the toolkit manifest."""
    repo_root = get_repo_root()

    try:
        manifest_data = get_manifest_data(repo_root)
        output_path = write_manifest(repo_root, manifest_data)

        print(f"Generated toolkit manifest: {output_path}")
        print(f"  Version: {manifest_data['version']}")
        print(f"  Packages: {len(manifest_data['toolkit_packs'])}")
        print(f"  Pages: {len(manifest_data['pages'])}")
        sys.exit(0)
    except Exception as e:
        print(f"ERROR: Failed to generate manifest: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == '__main__':
    main()

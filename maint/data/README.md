# Structured Toolkit Data — YAML Registries

This directory contains machine-readable registries of toolkit resources, official sources, and use case scenarios. These files support discoverability, validation, and potential future integrations.

## Files

### toolkit-registry.yml

Structured registry of all toolkit packs, templates, checklists, and guidance materials.

**Fields per entry:**
- `id` — machine-readable identifier
- `title` — human-readable name
- `type` — pack, reference, or guidance
- `path` — location in the repository
- `purpose` — what this resource is for
- `description` — longer explanation
- `recommended_for` — use case tags
- `review_level` — foundational, moderate, practical, illustrative, reference, guidance

**Use cases:**
- Navigation and discoverability
- Generating toolk documentation or indexes
- Recommending resources based on user context
- Validating that all toolkit materials are registered

### official-sources.yml

Registry of official EU AI Act sources and authoritative guidance.

**Fields per entry:**
- `id` — identifier
- `title` — source name
- `source_type` — regulation, guidance, policy, agency, reference
- `url` — external link to the source
- `institution` — which EU institution publishes it
- `publication_date` — when released (if applicable)
- `use_for` — what to use this source for
- `notes` — additional context

**Important note:** These are external sources maintained by EU institutions. The toolkit is not affiliated with any EU institution.

### use-cases.yml

Common AI tool use case scenarios with readiness guidance.

**Fields per entry:**
- `id` — scenario identifier
- `title` — descriptive name
- `sector_or_function` — area of business
- `likely_attention_level` — low, moderate, high (indicative)
- `description` — what this use case involves
- `key_concerns` — governance considerations
- `recommended_starting_points` — which toolkit materials to consult
- `escalation_triggers` — when to involve specialists
- `pack_reference` — link to relevant sector pack

**Important note:** Attention levels are indicative only and based on common patterns. Your specific context determines the appropriate response.

## How to Use These Files

### For Human Navigation
The `toolkit-registry.yml` and `use-cases.yml` can be manually reviewed to understand what the toolkit offers and which materials apply to specific scenarios.

### For Programmatic Use (Future)
These YAML files can be:

1. **Parsed and indexed** for dynamic navigation or search
2. **Validated** against the actual repository structure to ensure completeness
3. **Consumed by web applications** to recommend resources dynamically
4. **Used in documentation generation** to keep guides and indexes up-to-date
5. **Cross-referenced** to validate consistency across toolkit materials

### For Validation
Each registry file is checked in CI against a **document-level** JSON Schema in `maint/schemas/` (`*.document.schema.json`). To run the same check locally:

```bash
python3 -m pip install -r maint/tools/requirements-ci.txt
python3 maint/tools/validate_data_registries.py
```

If you add or rename fields in a registry entry, update the matching document schema so the contract stays explicit.

Quality checks can also verify over time:
- That all `path` entries reference files that actually exist
- That `recommended_starting_points` point to real toolkit materials
- That use cases are consistent with sector packs

## Format

All files use YAML 1.2 syntax for simplicity and readability. No special parsing libraries are required; they are plain text.

```yaml
key: value
nested:
  - id: item_1
    title: Item Title
    fields:
      - key1
      - key2
```

## Future Enhancements

Potential extensions:

- **Version history** — track when registries are updated
- **Relationships** — explicitly link related resources
- **Tags** — more fine-grained categorization
- **Search metadata** — keywords for discovery
- **Translations** — support for multiple languages
- **API schema** — formal OpenAPI/JSON Schema definitions

None of these are required now; the current registries serve their practical purpose.

## Important Disclaimers

- These registries are informational and educational.
- The toolkit is not legal advice and does not determine compliance.
- Official sources (EUR-Lex, EC) are the authoritative references.
- Use case attention levels are indicative; your context may differ.
- Consult qualified professionals for legally significant decisions.

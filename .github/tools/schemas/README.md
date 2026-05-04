# JSON Schemas for Structured Data

This directory contains JSON Schema definitions (draft 2020-12) for toolkit data structures, enabling validation and documentation of AI system inventories, risk screenings, and vendor assessments.

## Files

### ai-system-inventory.schema.json

Validates data for tracking AI tools and systems in use within an organisation.

**Key properties:**
- `system_id` — Unique identifier
- `name` — Tool or product name (required)
- `vendor` — Provider of the tool
- `category` — Type of AI use (required)
- `owner_name` — Person/team responsible (required)
- `data_processed` — Types of data processed
- `review_status` — Current governance review status
- `dpa_in_place` — Whether Data Processing Agreement exists

**Required fields:** name, category, owner_name

**Use case:** Populating the AI System Inventory template or tool in toolkit/templates/ai-system-inventory.csv

### risk-screening.schema.json

Validates readiness and risk screening results for AI systems.

**Key properties:**
- `screening_id` — Unique screening identifier
- `ai_system_id` — Reference to the AI system being screened (required)
- `data_risk` — Assessment of data handling risks
- `oversight_risk` — Assessment of human oversight gaps
- `vendor_clarity` — Clarity of vendor AI documentation
- `escalation_recommended` — Whether escalation needed
- `overall_readiness` — Final determination (required)

**Readiness values:** ready, needs_remediation, escalate, do_not_use

**Required fields:** ai_system_id, screening_date, reviewer_name, overall_readiness

**Use case:** Validating Risk Screening results from toolkit/templates/ai-risk-screening-form.md

### vendor-review.schema.json

Validates vendor AI assessment documentation.

**Key properties:**
- `vendor_name` — Vendor name (required)
- `product_name` — Product/service name (required)
- `ai_transparency` — Vendor transparency about AI
- `model_traceability` — Explainability of model decisions
- `training_data_clarity` — Disclosure of training data sources
- `bias_mitigation` — Address of fairness concerns
- `human_override_capability` — User override capability
- `dpa_in_place` — Data Processing Agreement status
- `overall_assessment` — Final assessment (required)

**Assessment values:** approved, approved_with_conditions, needs_further_review, not_recommended

**Required fields:** vendor_name, product_name, review_date, reviewer_name, overall_assessment

**Use case:** Validating vendor assessment data from toolkit/vendor-pack/ templates and tools

### Document schemas for YAML registries (`*.document.schema.json`)

These validate the **root structure** of the machine-readable files under `.github/tools/data/`:

- `toolkit-registry.document.schema.json` — `.github/tools/data/toolkit-registry.yml`
- `official-sources.document.schema.json` — `.github/tools/data/official-sources.yml`
- `use-cases.document.schema.json` — `.github/tools/data/use-cases.yml`

They are separate from the instance schemas above (inventory / screening / vendor review rows). Document schemas use `additionalProperties: false` on each registry entry: adding a new field requires updating the schema deliberately, which keeps CI catches meaningful.

**Validate in CI or locally:** see [data/README.md](../data/README.md) and run `python3 .github/tools/tools/validate_data_registries.py` after installing [requirements-ci.txt](../../.github/tools/tools/requirements-ci.txt).

### Sample JSON instances (`samples/`)

Minimal valid examples for each instance schema live under `samples/`. They are checked in CI with `python3 .github/tools/tools/validate_schema_samples.py` so breaking changes to a schema surface immediately.

## How to Use

### Validation

Use a JSON Schema validator (online or CLI) to validate instances against these schemas:

```bash
# Example with Python
python3 -m json.tool .github/tools/schemas/ai-system-inventory.schema.json

# Example with online validator
# https://www.jsonschemavalidator.net/
```

### Integration

These schemas can be:

1. **Embedded in tools** — Web forms or CLI tools can use schemas for field validation
2. **Used in automation** — CI/CD pipelines can validate evidence packs before archival
3. **Documented programmatically** — Schema properties can generate API documentation
4. **Extended** — Add organisation-specific fields via `$defs` or composition

### No Warranty

These schemas are informational and educational. They do not constitute legal advice and do not guarantee compliance with the EU AI Act or any jurisdiction's laws.

## Format

All schemas use JSON Schema draft 2020-12 syntax. Properties marked `"additionalProperties": false` enforce strict schema compliance (no extra fields allowed).

## Future Extensions

Potential additions:

- Conditional schemas (e.g., if vendor_clarity = "low", then escalation_recommended must be true)
- Custom error messages for better validation feedback
- Localized versions of descriptions
- Toolkit decision tree integration
- Automated schema generation from toolkit templates

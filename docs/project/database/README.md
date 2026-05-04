# Evidence Pack Schema

An optional SQLite-compatible schema for organisations that want to store structured AI governance evidence in an internal database.

## Purpose

This schema provides a lightweight, practical way for SMEs to:

- **Track AI tools** — inventory with ownership, vendors, data processing notes
- **Document risk screening** — results of readiness assessments for each tool
- **Record vendor reviews** — detailed assessments of third-party AI services
- **Log incidents** — track any concerns, breaches, or escalations
- **Maintain training records** — staff AI literacy and policy briefing attendance
- **Schedule reviews** — quarterly governance reviews and source updates

## Not Legal Advice

**This schema is an optional internal documentation aid only.**

It does not constitute legal advice and does not determine compliance. It is not a substitute for qualified professional legal, privacy, or security review. Use it as a practical organisational tool to maintain evidence of your readiness efforts.

## Tables

### ai_systems
Core registry of AI tools in use.
- `name`, `vendor`, `description`
- `category` (internal_genai, customer_chatbot, hr_recruitment, etc.)
- `data_processed` — brief description
- `owner` — responsible person/team
- `review_status` (pending, in_progress, completed, escalated)
- `last_reviewed_date`

### risk_screenings
Results of readiness screening for each tool.
- `ai_system_id` — reference to the tool
- `screening_date`
- `data_risk`, `oversight_risk`, `vendor_clarity` (low/moderate/high)
- `escalation_recommended` — boolean
- `escalation_reason`
- `reviewer`, `notes`

### vendors
Third-party vendors providing AI-enabled services.
- `name`, `product_name`
- `ai_features_description`
- `contract_signed_date`, `renewal_date`
- `dpa_in_place` — boolean
- `data_processing_terms` — brief summary
- `review_status` (pending, reviewed, approved_with_conditions, rejected)

### vendor_reviews
Detailed vendor AI practice assessments.
- `vendor_id` — reference to vendor
- `review_date`
- `ai_transparency`, `model_traceability`, `training_data_clarity` (low/moderate/high)
- `bias_mitigation` — boolean
- `human_override_capability` — boolean
- `escalation_required` — boolean
- `decision_record_link`

### incidents
Log of incidents or escalations.
- `ai_system_id` — reference to tool (optional)
- `incident_date`
- `description`
- `severity` (low, moderate, high)
- `category` (data_breach, bias_alert, accuracy_issue, escalation, other)
- `actions_taken`
- `resolved_date`

### ai_literacy_records
Track staff training on AI policy and governance.
- `staff_member_identifier` — anonymous (avoid storing PII)
- `training_type` (policy_briefing, literacy_session, vendor_training, other)
- `training_date`
- `completion_status` (pending, in_progress, completed)

### maintenance_reviews
Periodic governance review records.
- `review_date`
- `review_type` (quarterly_review, incident_debrief, policy_update, vendor_recheck)
- `ai_systems_count`
- `changes_made`
- `escalations_identified`

### source_updates
Track review of official regulation and toolkit sources.
- `source_title`, `source_type` (regulation, policy, guidance, template)
- `last_checked_date`
- `url`
- `status` (current, outdated, superseded, archived)

## Important Notes

**Security & Privacy:**
- Do not store sensitive personal data (PII, credentials, logs) in this database without encryption and strong access controls.
- This is intended for internal use only; do not publish it publicly.
- Use anonymous identifiers (roles, teams) instead of personal names where possible.

**Relationship to Toolkit Materials:**
- Link to specific toolkit templates using `decision_record_link` and similar fields.
- Cross-reference the `ai-system-inventory.csv` template for column definitions.
- Use `risk_screenings` to record results of the `ai-risk-screening-form.md`.

**Optional & Lightweight:**
- This schema is entirely optional. You can manage AI governance without a database.
- It is lightweight and can be extended or simplified to fit your needs.
- Use it if structured, queryable records help your governance process.

## Example Usage

```sql
-- Insert an AI tool
INSERT INTO ai_systems (name, vendor, owner, description, review_status)
VALUES ('ChatGPT Plus', 'OpenAI', 'marketing_team', 'Content generation for campaigns', 'pending');

-- Record a screening result
INSERT INTO risk_screenings (ai_system_id, screening_date, data_risk, oversight_risk, escalation_recommended)
VALUES (1, '2025-05-03', 'moderate', 'low', 0);

-- Track a vendor review
INSERT INTO vendor_reviews (vendor_id, review_date, ai_transparency, escalation_required)
VALUES (1, '2025-05-03', 'moderate', 0);
```

## Further Reading

- `../toolkit/templates/ai-system-inventory.csv` — use this alongside the `ai_systems` table
- `../toolkit/templates/ai-risk-screening-form.md` — document findings in `risk_screenings`
- `../toolkit/vendor-pack/templates/vendor-ai-due-diligence-questionnaire.md` — populate `vendor_reviews`

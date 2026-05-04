# Basic Risk Screening (Practical)

This guide supports a lightweight "first pass" screening for each AI system/use case. It helps you identify where deeper work may be needed.

Template: [../templates/ai-risk-screening-form.md](../templates/ai-risk-screening-form.md)

## What This Screening Tries To Answer

- What is the AI used for and who is impacted?
- Is the use case potentially sensitive or high-impact?
- What data is involved and what are the main risks?
- What do we rely on vendors/providers to do?
- What controls do we have (or need) for human oversight and incidents?

## Screening Heuristics (SME-Friendly)

Flag for deeper review if any apply:

- The AI influences employment decisions (hiring, promotion, termination).
- The AI influences education admissions or student outcomes.
- The AI influences access to essential services (credit, insurance, housing, healthcare).
- The AI is used in law enforcement, border control, or similar sensitive contexts.
- The AI processes children's data or special categories of personal data.
- The AI is customer-facing and can materially mislead users (for example medical, legal, financial advice).

If flagged:

- pause deployment expansion until you have documented controls and escalation paths
- involve legal/compliance/privacy counsel

## Evidence to Collect Early

- vendor documentation about intended use, limitations, and monitoring
- your internal decision record for why this use is appropriate
- incident logging approach (even if "no incidents yet")

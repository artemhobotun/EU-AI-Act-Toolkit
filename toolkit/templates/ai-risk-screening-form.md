# AI Risk Screening Form (Template)

This form is a lightweight starting point to identify where deeper review may be needed. It is not a legal determination. See [../../docs/DISCLAIMER.md](../../docs/DISCLAIMER.md).

System / Use case name:
System ID (from inventory):
Owner:
Date:

## 1. Purpose and Context

- What is the AI system used for?
- Where is it used? (internal / customer-facing / both)
- Who uses it?
- Who is impacted (customers, employees, applicants, etc.)?

## 2. Role and Dependencies

- Are we a provider, deployer, or both (for this use case)?
- Vendor(s) / model(s) used:
- Is this general-purpose AI (GPAI) based? (yes/no/unknown)
- Do we fine-tune, retrain, or substantially modify anything? (yes/no/unknown)
- What do we rely on vendors to do (monitoring, safety features, documentation)?

## 3. Data and Security

- What inputs go into the system?
- Does it process personal data? (yes/no/unknown)
- Does it process special categories or children's data? (yes/no/unknown)
- Are confidential business data or secrets involved? (yes/no)
- Where is data stored and for how long (if known)?

## 4. Impact and Sensitivity

Check any that apply:

- employment (hiring, performance, termination)
- education (admissions, grading, evaluation)
- credit / banking / insurance
- law enforcement / public authorities
- migration / asylum / border control
- biometric identification or categorization
- critical infrastructure
- healthcare
- essential services or access to services
- the AI influences decisions about people (even with a human in the loop)

Notes:

## 5. Human Oversight

- What requires human review before action?
- Who can override/stop the system?
- What escalation path exists when outputs look unsafe or wrong?

## 6. Monitoring and Performance

- What do we monitor? (quality metrics, drift, false positives, user complaints)
- How often?
- Who owns monitoring?

## 7. Incident Readiness

- What counts as an "AI incident" for this system?
- How do we log incidents? (link)
- Who is the incident owner?

Template: [ai-incident-log.md](ai-incident-log.md)

## 8. Documentation Check (What Do We Have Today?)

- Inventory entry exists (link):
- Vendor docs captured (link):
- Internal decision record exists (link):
- Policy / usage rules applied (link):
- Logging and monitoring evidence (link):

## 8. Outcome

Pick one:

- Proceed with baseline controls (documented oversight + monitoring).
- Proceed only after deeper review (legal/privacy/security).
- Pause/stop until the use case is redesigned or risks are addressed.

Decision notes:
Links to evidence:

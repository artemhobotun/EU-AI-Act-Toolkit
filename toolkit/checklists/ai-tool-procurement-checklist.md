# AI Tool Procurement Checklist

Use this checklist before buying, renewing, or enabling a new AI tool or AI feature.

This checklist is a practical control for SMEs. It does not provide compliance assurance. See [../../docs/DISCLAIMER.md](../../docs/DISCLAIMER.md).

## 1. Use Case Clarity

- [ ] Documented the business purpose and intended users
- [ ] Identified impacted persons (customers, employees, applicants, etc.)
- [ ] Confirmed whether the tool is internal-only or customer-facing
- [ ] Recorded the tool in the AI inventory (or created a draft entry)

## 2. Data and Privacy

- [ ] Listed data categories processed (inputs and outputs)
- [ ] Checked if personal data is processed
- [ ] Checked if special category data or children's data is involved
- [ ] Confirmed data retention defaults and options
- [ ] Confirmed whether customer data is used for vendor training by default, and opt-out settings
- [ ] Confirmed subprocessors list and update mechanism
- [ ] Confirmed DPA availability (or documented why not)

## 3. Security

- [ ] Confirmed authentication and access controls (SSO, RBAC, admin logs)
- [ ] Confirmed encryption and security posture documentation
- [ ] Confirmed incident notification process and timelines (contractual, if possible)
- [ ] Confirmed audit logs available and export format
- [ ] Confirmed ability to disable the AI feature (if it's a SaaS feature toggle)

## 4. Governance and Controls

- [ ] Defined human review requirements for the tool's outputs
- [ ] Confirmed monitoring signals (quality checks, logging, exports)
- [ ] Confirmed how major model/tool changes are communicated
- [ ] Confirmed whether the AI feature can be disabled
- [ ] Clarified whether the vendor is using general-purpose AI (GPAI) models and which ones

## 5. Vendor Questionnaire

- [ ] Completed vendor questionnaire:
  - [../templates/vendor-ai-questionnaire.md](../templates/vendor-ai-questionnaire.md)

## 6. Decision

- [ ] Approved / Approved with conditions / Rejected
- [ ] Conditions documented (policy updates, training, restricted use, monitoring, contract terms)
- [ ] Inventory updated:
  - [../templates/ai-system-inventory.csv](../templates/ai-system-inventory.csv)

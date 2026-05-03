# Provider vs Deployer (Practical Explainer)

This document is a simplified explainer to help SMEs organize responsibility. It is not a legal determination.

## Why It Matters

Your EU AI Act obligations depend heavily on your role(s). Many SMEs are both:

- provider for one system (a product feature you ship)
- deployer for another (a third-party tool you use internally)

## Quick Definitions (Simplified)

- Provider: you develop an AI system (or have it developed) and place it on the market or put it into service under your name/trademark, or you substantially modify it.
- Deployer: you use an AI system under your authority (for example internally, or to deliver a service), without being the provider.

## Practical Questions To Decide Your Role

Answer per system/use case:

1. Do we ship this to customers as part of our product/service?
2. Do we decide how it behaves in the real world (inputs, prompts, workflows, thresholds)?
3. Do we substantially change the model/system compared to the vendor's standard offering?
4. Who is accountable to customers for how it performs?

If "yes" to (1) or (4), you are likely acting as a provider for that use case.
If you mainly use a third-party tool in-house, you are likely acting as a deployer.

## Common SME Scenarios

- Using a SaaS "AI assistant" internally:
  - usually deployer, but you still need governance and procurement controls
- Shipping a "smart scoring" feature to customers:
  - often provider (or both), and you need stronger documentation
- Fine-tuning a model for your product:
  - role may shift toward provider responsibilities; document what changed and why

Record your role choice in the inventory: [../templates/ai-system-inventory.csv](../templates/ai-system-inventory.csv)

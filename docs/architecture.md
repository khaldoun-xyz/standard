# Khaldoun's architecture

Khaldoun as an organisation relies on a platform with various building blocks.

- A deployment environment (droplets & databases configured via Terraform),
  and standardised IT components (webhooks, Github Actions, Sentry).
- An analytics sandbox for exploration
  around data extraction (LabelStudio, file storage).
- A [process library](/docs/processes.md) and a
  [process recertification process](/docs/processes.md#certify-processes).
- An orchestrator that receives webhooks and triggers actions.
  We do not have a strong solution yet.

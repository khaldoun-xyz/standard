# Khaldoun's architecture

Khaldoun as an organisation relies on a series of building blocks in order to scale.

- A deployment environment (Digital Ocean droplets configured via Terraform),
  and standardised IT components (webhooks, Github Actions, Sentry).
- A [process library](/docs/processes.md) and a
  [process recertification process](/docs/processes.md#certify-processes).
- An event listener that receives webhooks. We do not have a strong solution yet.
- An automation orchestrator. We rely on automatisch.io.
- A data lake that receives data from our system databases and a dashboarding solution.
  We do not have a strong solution yet.


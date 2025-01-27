Khaldoun as an organisation relies on a series of building blocks in order to scale. 

- A deployment environment, a config library and standardised IT components. We rely on Digital Ocean droplets that we configure using Terraform, GitHub Actions for CI/CD and Sentry for monitoring. 
- A process library and a process recertification process. 
- An automation orchestrator. We rely on automatisch.io.
- An event listener that receives webhooks. We do not have a strong solution yet. 
- A data lake that receives data from our system databases and a dashboarding solution. We do not have a strong solution yet. 
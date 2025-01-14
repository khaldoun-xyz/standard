# Khaldoun's process library

Our eventual goal is the creation of autonomous
(i.e. highly automated) organisations.
To this end, we treat Khaldoun as our first test case.
We aim to design this company in a way to enable scalable automation.

Three critical elements for such a design are a company
orchestration layer, a process library and a recertification process.

- The orchestration layer is a light-weight, easy-to-switch hub
  where all automation tasks are registered.
- The process library is a central repository that contains all
  critical org processes.
- The recertification process is a recurring task that asks
  process owners to certify the correctness of processes.

## Process library

- [company orchestration](#company-orchestration)
  - process library (this section)
  - [certify processes](#certify-processes)
  - [register tasks in the orchestration layer](#register-tasks-in-the-orchestration-layer)
- recruiting
  - publish job description & receive applications
  - evaluate candidates
- training
  - evaluate language competence
  - teach mindset
  - teach skills
- [product maintenance](#product-maintenance)
  - [deploy product releases](#deploy-product-releases)
  - [continuously send kpis](#continuously-send-kpis)
  - [continuously track product uptime and errors](#continuously-track-product-uptime-and-errors)
- product development
  - generate & explore ideas
  - align & execute

### company orchestration

#### certify processes

owner: s0288

- The process is registered in recert.
- The process recertification tool lists all processes.
  - Each process has a name, an owner, a status, a certification date,
    a trigger period (e.g. annual) and an url to the record in the process library.
    Also, a history of edits to these data fields is available.

~~~mermaid
---
title: certify processes
---
flowchart LR
  A[annual trigger] --> B[log status & reset]
  B --> C[send Telegram message to all process owners]
  C --> |#1| D('Review your process description. Do you need to update it?')
  C --> |#2| E[...]
  C --> |#3| F[...]
  D --> |yes| G(update the record in the process library)
  D --> |no| H(confirm the record in the process library)
  G --> I[end]
  H --> I
~~~

#### register tasks in the orchestration layer

owner: s0288

The orchestration layer is the central hub
where automation tasks are registered.
We develop independent modules
that are connected by the orchestration layer.

One candidate for this orchestration layer is automatisch.io:

- Screenshot of a flow:
<img src="./imgs/screenshot-automatisch-flow.png">

- Screenshot of the folder structure:
<img src="./imgs/screenshot-automatisch-folder.png">

### Product maintenance

#### deploy product releases

owner: s0288

- Each product's process is registered in recert.
- In your repo, set up Github Actions by following [this guide](https://medium.com/swlh/how-to-deploy-your-application-to-digital-ocean-using-github-actions-and-save-up-on-ci-cd-costs-74b7315facc2).
  - Use [this Github Actions deploy.yml](https://github.com/khaldoun-xyz/lugha/blob/main/.github/workflows/deploy.yml)
    as a template.
- In your Digital Ocean droplet `/root`, run `git clone <repo>`, create the `.env` file both in `/root/<repo>` as well as in `/root` and manually deploy. 

~~~mermaid
---
title: continuously deploy after master/main merge
---
flowchart LR
  A[merge in product's master/main branch] --> B[trigger Github Action]
  B --> C[deploy to Digital Ocean droplet]
  C --> D[end]
~~~

#### continuously send kpis

owner: s0288

- Each product's process is registered in recert.

~~~mermaid
---
title: continuously send kpis
---
flowchart LR
  A[weekly product webhook with kpis] --> B[send Telegram message to admins]
  B --> C[end]
~~~

#### continuously track product uptime and errors

owner: s0288

- Each product's process is registered in recert.
- Set up [Sentry webhook as internal integration](https://docs.sentry.io/organization/integrations/integration-platform/webhooks/issue-alerts/).
  - Connect automatisch.io webhook, [connect Telegram bot](https://automatisch.io/docs/apps/telegram-bot/connection) and send message via Telegram. If you don't know your Telegram user id, send /start to the @userinfobot on Telegram.
  - Set up Issue and Uptime Monitor alerts.

~~~mermaid
---
title: continuously track product uptime and errors
---
flowchart LR
  A[sentry error webhook] --> B[send Telegram message to admins]
  B --> C[end]
~~~

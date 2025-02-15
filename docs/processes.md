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
- recruiting
  - publish job description & receive applications
  - evaluate candidates
- onboarding 
  - [first week](#first-week) 
- training
  - [evaluate language competence](#evaluate-language-competence)
- [product maintenance](#product-maintenance)
  - [deploy product releases](#deploy-product-releases)
  - [(re-)certify ssl](#re-certify-ssl)
  - [continuously send kpis](#continuously-send-kpis)
  - [continuously track product uptime and errors](#continuously-track-product-uptime-and-errors)
- product development
  - generate & explore ideas
  - [align and execute](#align-and-execute)
- expenses 
  - [log expenses](#log-expenses)

### company orchestration

#### certify processes

- The process recertification tool lists all processes.
  - Each process has a name, an owner, a status, a certification date,
    a trigger period (e.g. annual) and an url to the record in the process library.
    Also, a history of edits to these data fields is available.

~~~mermaid
---
title: certify processes
---
flowchart LR
  A[manually reset recurring Sisu checklist item 'certiy Khaldoun processes'] --> B[review process descriptions]
  B --> |yes| C(update the record in the process library)
  C --> D[manually complete Sisu checklist item]
  B --> D
  D --> E[end]
~~~

### Onboarding 

#### first week 

- Prepare a "Your first day"" message in advance and post it on Basecamp.
- Ask the candidate to read through the [welcome memo](../README.md)
  and to [set up his/her laptop](../setup/README.md). 
- [The new member signs up to Script](https://sisu.cx/script/).


### Training

#### evaluate language competence

When he or she joins, a Khaldoun member is expected
to start learning a language that he or she isn't fluent in yet.
We suggest this language to be German
but don't mind if another language is chosen.

Each member is expected to regularly talk to [Lugha](https://lugha.xyz/)
to track his or her progress.
In regular intervals, Lugha sends the scores to the member's coach
who keeps the member accountable.
At the end of the first six months with Khaldoun,
members are expected to have an overall competence score
of at least 50 out of 100.

~~~mermaid
---
title: evaluate language competence
---
flowchart LR
  A[member talks to Lugha] --> B[Lugha logs competence score]
  B --> C[end]
  D[Lugha sends monthly avg. score to coach] --> E[if need be, coach discusses progress with member]
  E --> F[end]
~~~

### Product maintenance

#### deploy product releases

- For initial installation:
  - In your Digital Ocean droplet `/root`, run `git clone <repo_url>`, create the `.env` file both in `/root/<repo_dir>` as well as in `/root` (`.env` in `/root` is necessary for Github Action) and manually deploy.
  - In your repo, set up Github Actions by following [this guide](https://medium.com/swlh/how-to-deploy-your-application-to-digital-ocean-using-github-actions-and-save-up-on-ci-cd-costs-74b7315facc2).
    - Use [this Github Actions deploy.yml](https://github.com/khaldoun-xyz/lugha/blob/main/.github/workflows/deploy.yml)
      as a template.

~~~mermaid
---
title: continuously deploy after master/main merge
---
flowchart LR
  A[merge in product's master/main branch] --> B[trigger Github Action]
  B --> C[deploy to Digital Ocean droplet]
  C --> D[end]
~~~

#### (re-)certify ssl

~~~mermaid
---
title: set up ssl
---
flowchart LR
  A[set up project's docker-compose with gunicorn & nginx service]
  A --> B[in nginx.conf, comment out ssl mentions]
  B --> C[deploy project in droplet]
  C --> D[in droplet's project root, run ssl cert command]
  D --> E[in nginx.conf, activate ssl mentions & redeploy]
  E --> F[end]
~~~

~~~mermaid
--- 
title: recertify ssl
---
flowchart LR
  A[in droplet's project root run ssl cert command]
  A --> B[end]
~~~

- Examples
  - [Lugha's docker-compose.yml](https://github.com/khaldoun-xyz/lugha/blob/main/docker-compose.yml)
  - [Lugha's nginx.conf](https://github.com/khaldoun-xyz/lugha/blob/main/nginx.conf)
  - ssl recert command: ```docker run -it --rm -v $(pwd)/html:/var/www/html
    -v /etc/letsencrypt:/etc/letsencrypt
    certbot/certbot certonly --webroot -w /var/www/html -d lugha.xyz```

- Troubleshooting
  - at initial run
    - `sudo mkdir -p /var/www/html`
    - `sudo chown -R www-data:www-data /var/www/html`
  - firewall problems
    - `sudo ufw allow 80`
    - `sudo ufw allow 443`
    - `sudo ufw allow https`
    - `chmod -R 755 /etc/letsencrypt`
    - `chmod 644 /etc/letsencrypt/live/PROJECT_FOLDER/*.pem`

#### continuously send kpis

~~~mermaid
---
title: continuously send kpis
---
flowchart LR
  A[weekly product webhook with kpis] --> B[send Telegram message to admins]
  B --> C[end]
~~~

#### continuously track product uptime and errors

- For initial installation:
  - Set up [Sentry webhook as internal integration](https://docs.sentry.io/organization/integrations/integration-platform/webhooks/issue-alerts/).
  - Connect automatisch.io webhook, 
    [connect Telegram bot](https://automatisch.io/docs/apps/telegram-bot/connection) 
    and send message via Telegram. If you don't know your Telegram user id, 
    send /start to the @userinfobot on Telegram.
    - Set up Issue and Uptime Monitor alerts.

~~~mermaid
---
title: continuously track product uptime and errors
---
flowchart LR
  A[sentry error webhook] --> B[send Telegram message to admins]
  B --> C[end]
~~~

### Product development

#### Align and execute

We do [weekly check-ins](/README.md#weekly-check-ins)
and set [quarterly objectives & key results](/README.md#quarterly-planning).

~~~mermaid
---
title: Weekly check-ins
---
flowchart LR
  A[start of week Basecamp notification] --> B[member publishes plan]
  B --> C[others may comment]
  C --> D[end]
  E[end of week Basecamp notification] --> F[member reflects on progress]
  F --> G[others may comment]
  G --> H[end]
~~~

~~~mermaid
---
title: Quarterly planning
---
flowchart LR
  A[quarterly Basecamp notification] --> B[member suggests OKRs]
  B --> C[others may comment]
  C --> B
  C --> D[end]
  E[monthly meeting to discuss progress] --> F[end]
~~~

### Expenses 

#### Log expenses 

~~~mermaid
---
title: Log expenses
---
flowchart LR
  A[upload expense proof to Sisu] --> B[label expenses in bank account]
  B --> C[log expenses in Excel]
  C --> D[end]
~~~

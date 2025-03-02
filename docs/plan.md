# Our plan with Khaldoun

Khaldoun is a technology company that **helps people do more with less**.
To do so, we develop and maintain open-source tools & systems.

Over time, Khaldoun aims to become a vehicle
to build **unbureaucratic bureaucracies** - organisations that actively
reduce complexity & orchestrate automation.
This is not possible by tweaking existing legacy systems.
Instead, **we'll specifically design organisations**.

## Developmental stages

Khaldoun will go through a series of developmental stages
as we continue to grow. These stages are important as we
need to develop a number of fundamental building blocks
for Khaldoun to succeed.

### Stage 1: Build a trade school

At its core, Khaldoun is a technology company
that wants to foster growth for a long time.
Sustaining this core requires access
to a supply of highly-educated technologists
(e.g. software developers, data scientists, data engineers,
AI specialists, product managers, devops engineers, ...).
To that end, we will set up a trade school
to train ourselves and others.

Khaldoun will develop open-source products, offer educational
material and provide learning opportunities - all with
the goal to strengthen skills of potential Khaldoun members.

- Our first open-source product is
  <a href="https://lugha.xyz" target="_blank">Lugha</a>.
  Members of Khaldoun are expected to work in international work contexts,
  which typically requires speaking foreign languages.
  Lugha allows us to evaluate the language competences
  of our members in a highly automated fashion.

### Stage 2: Develop operating system (OS) for healthcare organisations

Our strategy is to a) develop an open-source toolbox for automation & orchestration
and to b) combine these tools into an automation-first operating system (OS).

Core building blocks of this toolbox are ...

- i) a webform process to send sensitive data into the backend (using Django & SpiffWorkflow)
- ii) an unstructured data manager that transforms unstructured documents to structured tasks
- iii) an AI assistant that employees forward tasks to (e.g. documentation)

The webform process is a Django webapp that sends a webhook to a BPMN workflow.
The workflow can then flexibly do various things (e.g. send emails to patient & insurer).

The unstructured data manager is a simple-to-understand BPMN workflow that takes in 
documents and creates tasks to complete out of them.
You connect your email address and all emails will be routed 
through the unstructured data manager.

Eventually, we'll find a way how to deploy these orchestration components quickly.
Once we've reached this stage, we'll approach newly started long-term care organisations 
to help them integrate our OS in infancy.

### Stage 3: Set up healthcare organisations

Once we have set up an operating system for healthcare organisations,
we'll use it to set up our own organisation.
We will set up Renard, an European healthcare organisation,
that provides healthcare services.


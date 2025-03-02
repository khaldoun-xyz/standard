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

### Stage 2: Help health insurers cut their spending 

The German healthcare system has an expense problem, 
especially in private health insurance. 
Thus, we need a) big automation programmes and b) big service-reduction programmes.

There are at least 3 kinds of rejections that private health insurers want to realise:

- charlatan invoices: obviously bad practices
- pre-authorisation
- excessive invoices: bad practices but muddled because physicians can argue it is necessary

On the one hand, private health insurers want to improve their rejection practices. 
And on the other hand, customers benefit from knowledge about rejections they'll likely incur.

As a first step, we will develop an AI with knowledge of the Gebührenordnung für Ärzte 
that customers can use to see likely rejections 
on their physician's price quotes (Kostenvoranschlag). 
With this AI, we will approach private health insurers to help them improve their rejection activities.

### Stage 3: Develop an operating system (OS) for healthcare organisations

Our strategy is to a) develop an open-source toolbox for automation & orchestration
and to b) combine these tools into an automation-first operating system (OS).

Core building blocks of this toolbox are ...

- i) a webform process to send sensitive data to the backend (using Django & SpiffWorkflow)
- ii) an unstructured data manager that transforms unstructured documents to structured tasks
- iii) an AI assistant that employees forward tasks to (e.g. documentation)

The webform process is a Django webapp that sends a webhook to a BPMN workflow.
The workflow can then flexibly do various things (e.g. send emails to patients & insurers).

The unstructured data manager is a simple-to-understand BPMN workflow that takes in 
documents and translates them into tasks.

Eventually, we'll find a way how to deploy these orchestration components quickly.
Once we've reached this stage, we'll approach newly started long-term care organisations 
to help them integrate our OS in infancy. We will also use it to set up our own 
healthcare organisations.


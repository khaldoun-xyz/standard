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
  process owners to certify that the processes are up to date
  and as simple as possible.

## Process library

- company orchestration
  - process library (this section)
  - [register tasks in the orchestration layer](#register-tasks-in-the-orchestration-layer)
  - [recertify processes and tasks](#recertify-processes-and-tasks)
- recruiting
  - publish job description & receive applications
  - evaluate candidates
- training
  - evaluate language competence
  - teach mindset
  - teach skills
- product maintenance
  - monitor production systems
- product development
  - generate & explore ideas
  - align & execute

### recertify processes and tasks

owner: s0288

#### flowchart

~~~mermaid
---
title: recertify processes & tasks
---
flowchart LR
  A[annual \n trigger] --> B[log status \n & reset]
  B --> C[notify all \n process owners]
  C -->|#1| D(do you need to \n update your \n process description?)
  C -->|#2| E[...]
  C -->|#3| F[...]
  D -->|yes| G(update the process \n in the library)
  D -->|no| H[end]
  G --> H
~~~

#### description

- The process is registered in the orchestration layer.
- The process recertification tool lists all processes.
  - Each process has a name, an owner, a status, a certification date,
    a trigger period (e.g. annual) and a history of edits to these data fields.

### register tasks in the orchestration layer

owner: s0288

#### description

The orchestration layer is the central hub
where automation tasks are registered.
We develop independent modules
that are connected by the orchestration layer.

One candidate for this orchestration layer is automatisch.io:
<img src="./imgs/screenshot-automatisch-flow.png">
<img src="./imgs/screenshot-automatisch-folder.png">

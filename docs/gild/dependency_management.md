# Pixi

## why?

- more convenient (no need to activate
  the virtual environment first, just run `pixi run ...` or `pixi shell`)
- everything in one place;
  - environments require requirements.txt or
    condaenv.yml and an independent virtual environment location
  - everything documented in one place, including the sub-dependencies
    (the pixi.lock file)
  - easy to see which commands (= tasks) are available

## how?

- install it (check pixi.sh): `pixi install`
- initialise pixi in your project: `pixi init`
- continuously add new commands to tasks section in `pixi.toml`
- `pixi add PACKAGE-NAME` (or just ask Cursor)
  - if you want to remove a package: `pixi remove PACKAGE-NAME`
- run commands with `pixi run TASK-NAME`
- enter the pixi shell with `pixi shell`
- we typically run a pixi Docker image

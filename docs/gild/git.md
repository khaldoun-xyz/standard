# Git: proper version control

- how to work with git in the industry (staging/prod/..., CI/CD)



## Why?

- don't lose data on local laptops
- keep track of full project history
- work on software in a group (e.g. share work safely via
  feature branches; improve changes via peer-reviewed
  pull requests)
- safe backup via rollback

## The 3 metal rules

- **number 1 golden rule**: always maintain a working version
  in the `main` brach as the **single source of truth**
- **number 2 silver rule**: always push all changes to Github
  as quickly as possible (even just as a feature branch
  without PR or as a draft PR)
- **number 3 bronze rule**: don't push directly into `main` (there
  are reasons why you would want to ignore this, e.g. emergencies)
- our style of work:
  - we merge or close branches as quickly as possible
  - we keep branches small with as few changes as possible
  - we keep our code easy to understand, e.g. by
      adding docstrings in your functions
  - when we identify a problem, we write a Github issue
      & add a priority to it, then we open a PR for it;
      when we merge the PR, we close the issue
- punishment if Khaldoun members ignore the rules:
  - cook or bake a lot (e.g. 3 cakes) & bring it to the office

## important git commands

- `git init`
- `git remote add REMOTE_NAME REMOTE_URL`
- `git status`
- `git add .`
- `git commit -m "commit message"`
- `git push`
- `git log`
- `git pull` = `git fetch + git merge`
- `git fetch`
- `git branch`
- `git checkout -b NEW_BRANCH_NAME`
- `git stash` --> store local changes in system memory
- `git stash pop` --> revert `git stash`
- `git merge main`: Add a new commit that merges the changes from `main`
  into your feature branch.
- `git revert HEAD` --> Add a new commit that undoes the previous commit
- `git reset HEAD~1` --> Similar to `git revert` but changes the git
  history. Undo the previous commit and transform its changes
  to unstaged changes locally
- `git rebase -i HEAD~NUMBER_OF_COMMITS_YOU_WANT_TO_GO_BACK`
  --> interactively rebase your history (e.g. for squashing commits)

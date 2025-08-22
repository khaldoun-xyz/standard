# Git handbook

Git is an essential tool for version control in software development.
This guide will help you navigate Git effectively and follow best practices.

If you're new to Git, we recommend watching
[this comprehensive video series](https://www.youtube.com/watch?v=rH3zE7VlIMs)
for a solid foundation.

## Our git workflow

There are very few reasons where this workflow is not adequate:

**When you identify a problem that you want to resolve,
create an issue first. Then you create a PR that addresses this issue.
After the PR is merged, you close the issue.
Repeat.**

![Git workflow](./imgs/sketch-git_flow.png)

This means that very rarely would you ever create large PRs.
The **ideal PR is short and concise**.

### Best practices for Pull Requests (PRs)

1. **Keep your branch updated**
   - Regularly rebase your branch with the master using `git rebase master`.
     - Ensure you have the latest master branch locally before rebasing or merging.
   - If you have opened your branch already and have run into merge conflicts,
     refer to the ['Deal with merge conflicts'](#deal-with-git-merge-conflicts) section.

2. **Run pre-commit hooks**
   - Ensure all hooks pass before requesting reviews

3. **Open a `draft PR` right away**
   - Don't wait until your code change is finished.
     Open a `draft PR` immediately after your first commit.
   - Mark as "Ready for Review" when the PR is complete
     and you want to formally ask for a peer review.

4. **Add a clear PR description**
   - Always include a clear, well-formatted description
   - Avoid typos and formatting issues

5. **Provide clear commit messages**
   - Use descriptive commit messages
   - Consider using gitmojis for visual context (e.g., :bug:
     for bug fixes) - see [gitmoji.dev](https://gitmoji.dev/)
   - Squash minor commits into more meaningful ones
   - Set "Squash and merge" as the default merge option

6. **Resolve all PR comments**
   - Address all review comments
   - Click "Resolve conversation" after addressing a comment
   - Either resolve or provide clear responses to all comments

7. **Reference issues that you resolve in your PR**
   - Close related issues after merging PRs
   - Reference the resolving PR in the issue closure comment

### Deal with git merge conflicts

Generally, we recommend to fix merge conflicts by creating an additional commit.
The most typical case for merge conflicts stems from another PR that was merged
into `main`. Since you don't have the newest changes from `main` in your `feature`
branch yet, you need to bring them in.

First, pull the most recent changes to `main` from your remote branch `origin`:

- `git checkout main`
- `git pull origin main`

Next, merge your local `main` branch into your `feature` branch:

- `git checkout feature`
- `git merge main`

If there are merge conflicts, the merge will stop and you'll be asked
to resolve the merge conflicts in the files that are mentioned in the
error message first. Open each of these files and resolve your conflicts.

Then, add your updated file with `git add file1.py` and run `git commit`.
Confirm the commit message et voilà.

### Helpful git commands

Shown below is a subset of git commands.
Feel free to dive deeper.
Just remember you're still considered a solid English speaker
even if you don't know what 'transmogrify' means.

- `git init`: Initializes a new Git repository in the current directory.
- `git clone <git_url>`: Clone an existing repo to a local location.
- `git remote add origin <git_url>`: Adds a remote repository
  called "origin" to the local repository.
- `git status`: Displays the status of the repository, including any changes or conflicts.
- `git log`: Displays a log of all commits made in the repository.
- `git branch`: Show all existing branches.
- `git checkout -b <branch_name>`: Create a new branch and switch to it.
- `git checkout <branch_name>`: Switches to an existing branch.
  (If switching to another branch is impossible due to
  existing changes you haven't merged yet, type in `git stash` first.)
- `git add <file>`: Mark a file as "part of the next commit".
  (`git add .` marks all files in the current directory & subdirectories)
- `git stash`: Save uncommitted changes into temporary storage & remove them locally.
  (Use `git stash pop` to load the changes from the temporary storage.)
- `git commit -m "<message>"`: Commits changes with a meaningful commit message.
  (For longer commit messages just write `git commit`.)
- `git rebase master`: Load the most recent changes from master into your branch.
- `git rebase -i HEAD~<number_of_commits>`: interact with historical commits.
  Use this to squash minor/irrelevant commits by marking
  to-be-squashed commits with "s".
- `git push origin <branch_name>`: Pushes changes to the remote repository origin.
- `git pull origin`: Fetches and merges changes from the remote repository origin.
- `git reset --soft HEAD^`: revert the last commit
  and keep the changes in an uncommited stage.
  (Use `git reset --hard HEAD^` to revert the last commit and delete all changes.)

## Git repository setup

1. Use Khaldoun's git repo template: Whenever possible, create a new repo
   with [Assaas](https://github.com/khaldoun-xyz/assaas) as your base template.
2. Only allow squash merging: After creating the repo, go to General settings
   on Github, scroll to the `Pull Requests` section and
   only select `Allow squash merging`.
3. Auto-delete a branch after merging: In the same settings section, activate
   `Automatically delete head branches`.

None of the things described here are novel or surprising. This is intended. <br> 
I expect you to deeply understand the things described here. 

# git (version control)

## git commands
Shown below is only a subset of git commands. You'll use those a lot. 
Feel free to dive deeper into git. Just remember you're still considered a solid English speaker even if you don't know what 'transmogrify' means. 

- `git init`: Initializes a new Git repository in the current directory. 
  (To set up an existing repo locally, use `git clone <git_url>`.)
- `git remote add origin <git_url>`: Adds a remote repository called "origin" to the local repository.
- `git status`: Displays the status of the repository, including any changes or conflicts.
- `git log`: Displays a log of all commits made in the repository.
- `git branch`: Show all existing branches.
- `git checkout -b <branch_name>`: Create a new branch and switch to it.
- `git checkout <branch_name>`: Switches to a different branch. 
  (If switching to another branch is impossible due to irrelevant changes, type in `git stash` first.)
- `git add <file>`: Mark a file as "part of the next commit". 
  (`git add .` marks all files in the current directory & subdirectories)
- `git commit -m "<message>"`: Commits changes with a meaningful commit message.
  (For longer commit messages just write `git commit`.)
- `git rebase master`: Load the most recent changes from master into your branch.
- `git rebase -i HEAD~<number_of_commits>`: interact with historical commits. 
  Use this to squash minor/irrelevant commits by marking to-be-squashed commits with "s".
- `git push origin <branch_name>`: Pushes changes to remote repository origin.
- `git pull origin`: Fetches and merges changes from remote repository origin.

## git good case practices
Below is a basic list of good case practices when using git.

- When pushing a PR, rebase to the master branch with `git rebase master` 
  (make sure you have the most recent master locally!) 
  and resolve any merge conflict <u>before</u> asking for review.
- When your PR isn't ready for review yet (work in progress) 
  but you still want to share it with others, open the PR as `draft`.
- Squash minor git commits into fewer more relevant commits. 
  Set "Squash and merge" as default merge option of branches 
  (this collapses a branch with many commits into one feature commit in master).
- Where helpful, use gitmojis in your commit messages (e.g. for :bug:): https://gitmoji.dev/.
- Don't open PRs without descriptions. 
- Once you dealt with a PR comment, 
  click on "Resolve conversation" to indicate that you consider it resolved. 
  Either resolve all comments or provide responses.
- Close open issues with a reference to the PRs in which they are resolved after you've resolved them.
- use at least these pre-commit hooks: end-of-file-fixer, trailing-whitespace, black, isort. 
  Always make sure pre-commit hooks have run <u>before</u> asking for a review.


# bash (terminal interaction)
Being able to interact with a terminal console is necessary to not be limited by GUI functionality. 

- `cd ~/<path_to_folder>`: Jump into a directory.
- `ls -a`: Show all (also hidden) files in directory. (Use `ls -a -ll` for a more structured/detailed list.)
- `ctrl + r (keyboard shortcut)`: Reverse i search to find historical bash commands.
- `htop`: See cpu usage (similar to windows task manager, quit with "q").


# terminal setup
Add this to your .bashrc file.

## On Linux:
```
# show git branch in Terminal
function parse_git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
RED="\[\033[01;31m\]"
YELLOW="\[\033[01;33m\]"
GREEN="\[\033[01;32m\]"
BLUE="\[\033[01;34m\]"
NO_COLOR="\[\033[00m\]"
PS1="$GREEN\u$NO_COLOR:$BLUE\w$YELLOW\$(parse_git_branch)$NO_COLOR\$ "
```

## On Mac:
```
# show git branch in Terminal
function parse_git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
RED="%F{red}"
YELLOW="%F{yellow}"
GREEN="%F{green}"
BLUE="%F{blue}"
NO_COLOR="%f"
PS1="${GREEN}%n${NO_COLOR}:${BLUE}%~${YELLOW}\$(parse_git_branch)${NO_COLOR}%# "
```

# docker (containerised applications)
Docker removes many of the headaches around server configuration. If the docker runs on one system, it will run on another.

- `docker ps`: see a list of running docker containers
- `docker exec -it <initial_digits_of_container> sh`: enter a container & get terminal access


# power point (concept work)
When used properly, Power Point is a powerful tool to quickly visualise what you have in mind. This is even faster, when you use shortcuts.

- `ctrl + shift + .` = increase font size
- `ctrl + shift + ,` = decrease font size
- `ctrl + mouse wheel = zoom` = zoom
- `shift + arrow keys` = increase/decrease box size
- `ctrl + mouse movement` = duplicate box



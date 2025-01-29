# Internal memo for new Khaldoun members

Khaldoun wants to help you do more with less.
Like a surfer can use a wave to move forward effortlessly,
you can integrate tools & systems to stack your progress.

Please read this document carefully & don't skip parts
because you think you know all of this.

## Our plan with Khaldoun

Khaldoun's core purpose is to build tools & systems to do more with less.

To that end, we're working through a multi-stage plan.
Currently, we're in stage 1 and
focused on making Tunis more attractive for technologists.
Please read our plan carefully, make comments
and let us know when you think we lose sight of it:
<a href="./docs/plan.md" target="_blank">Our plan with Khaldoun</a>.

## Systems

The way we work works for us.
We would like to ask you to adapt to our way.
Feel free to propose changes that help us do more with less.

First off, we like to be *cheap, impatient and long-term focused*.
So please, don't waste money, push us to get things done fast and
make sure we have a plan.

- [extensive documentation](#extensive-documentation)
- [weekly check-ins](#weekly-check-ins)
- [quarterly planning](#quarterly-planning)

### Extensive documentation

We like to make things explicit & easy to understand.
We write a lot. We deal with many things asynchronously.
You might not be used to this yet. Still, we would like
to ask you to write your thoughts down. We're always happy to have
a discussion - after we had a look at something.

### Weekly check-ins

Very often, meetings are a waste of time. Still, we want to stay
in touch with each other and understand the general direction we're taking.
Therefore, on Mondays we write up and share our plan for the week.
You're invited to comment on anyone's plans.

### Quarterly planning

As we grow, the need for alignment increases. To make sure we're on the
same page and generally understand our overall direction, we set quarterly
Objectives and Key Results (OKRs). Please influence our OKRs.

## Technology skills

Below you can see a list of technologies that we apply on a daily basis.
While you won't use all of these tools right away, it is generally useful if you
familiarise yourself with our tech stack.

- [Terminal](#terminal)
- [Bash](#bash)
- [Pre-commit hooks](#pre-commit-hooks)
- [Vim motions](#vim-motions)
- [LazyVim](#lazyvim)
- [Git](#git)
- [Sql](#sql)
- [Docker](#docker)
- [Github Actions](#github-actions)
- [Power Point](#power-point)
- [Plotting](#plotting)

### Terminal

If you want to have helpful env/git information in your terminal,
add the following to your .bashrc file.

#### On Linux

``` bash
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

#### On Mac

``` bash
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

#### On Windows

Use [WSL](https://learn.microsoft.com/en-us/windows/wsl/install)
and follow the steps in the Linux section.

### Bash

Being able to interact with a terminal console is helpful
to not be limited by GUI functionality.

- `cd ~/<path_to_folder>`: Jump into a directory.
- `ls -a`: Show all (also hidden) files in directory.
  (Use `ls -a -ll` for a more structured/detailed list.)
- `ctrl + r (keyboard shortcut)`: Reverse i search to find historical bash commands.
- `htop`: See cpu usage (similar to windows task manager, quit with "q").

### Pre-commit hooks

We use [pre-commit hooks](https://github.com/khaldoun-xyz/lugha/blob/main/.github/workflows/deploy.yml)
to make sure our PRs fulfill minimum requirements
before other people have a look at them.
To install pre-commit hooks in your local repo,
simply run `pre-commit install`.
As one example, have a look at [Lugha's pre-commit hooks](https://github.com/khaldoun-xyz/lugha/blob/main/.pre-commit-config.yaml).

### Vim motions

Vim motions allow you to quickly work with your code.

- [This video series](https://www.youtube.com/watch?v=X6AR2RMB5tE&list=PLm323Lc7iSW_wuxqmKx_xxNtJC_hJbQ7R)
  gives you a good basic overview.
- [This cheatsheet](https://vim.rtorr.com/) contains many useful commands.

### LazyVim

- If you want to use LazyVim as your IDE,
you can follow this [installation video](https://manual.omakub.org/1/read/13/neovim).
And [here](https://manual.omakub.org/1/read/13/neovim)
is a list of useful LazyVim commands.
- If you want to use LazyGit, watch [this video](https://www.youtube.com/watch?v=CPLdltN7wgE).

### Git

Version control is a very basic and very useful tool.

- [This video series](https://www.youtube.com/watch?v=rH3zE7VlIMs)
  gives you a good basic overview.

#### Git good case practices

Below is a basic list of good case practices when using git.
Please refer to this list when you're unsure
how to ask your colleagues for a PR review.

- When pushing a PR, rebase to the master branch with `git rebase master`
  (make sure you have the most recent master locally!)
  and resolve any merge conflict <u>before</u> asking for review.
- When your PR isn't ready for review yet (work in progress)
  but you still want to share it with others, open the PR as `draft`.
- Squash minor git commits into fewer more relevant commits.
  Set "Squash and merge" as default merge option of branches
  (this collapses a branch with many commits into one feature commit in master).
- Where helpful, use gitmojis in your commit messages (e.g. :bug:): <https://gitmoji.dev/>.
- Don't open PRs without descriptions.
- Once you dealt with a PR comment,
  click on "Resolve conversation" to indicate that you consider it resolved.
  Either resolve all comments or provide responses.
- Close open issues with a reference to the PRs
  in which they are resolved after you've resolved them.
- use at least these pre-commit hooks: end-of-file-fixer,
  trailing-whitespace, black, isort.
  Always make sure pre-commit hooks have run <u>before</u> asking for a review.

#### Git commands

Shown below is only a subset of git commands. You'll use those a lot.
Feel free to dive deeper into git.
Just remember you're still considered a solid English speaker
even if you don't know what 'transmogrify' means.

- `git init`: Initializes a new Git repository in the current directory.
  (To set up an existing repo locally, use `git clone <git_url>`.)
- `git remote add origin <git_url>`: Adds a remote repository
  called "origin" to the local repository.
- `git status`: Displays the status of the repository, including any changes or conflicts.
- `git log`: Displays a log of all commits made in the repository.
- `git branch`: Show all existing branches.
- `git checkout -b <branch_name>`: Create a new branch and switch to it.
- `git checkout <branch_name>`: Switches to a different branch.
  (If switching to another branch is impossible due to
  irrelevant changes, type in `git stash` first.)
- `git add <file>`: Mark a file as "part of the next commit".
  (`git add .` marks all files in the current directory & subdirectories)
- `git stash`: Save uncommitted stages into temporary storage & remove them locally.
  (Use `git stash pop` to load the stages from temporary storage.)
- `git commit -m "<message>"`: Commits changes with a meaningful commit message.
  (For longer commit messages just write `git commit`.)
- `git rebase master`: Load the most recent changes from master into your branch.
- `git rebase -i HEAD~<number_of_commits>`: interact with historical commits.
  Use this to squash minor/irrelevant commits by marking
  to-be-squashed commits with "s".
- `git push origin <branch_name>`: Pushes changes to remote repository origin.
- `git pull origin`: Fetches and merges changes from remote repository origin.
- `git reset --soft HEAD^`: revert the last commit
  and keep the changes in uncommited stage.
  (Use `git reset --hard HEAD^` to revert the last commit and delete all changes.)

### Sql

Creating and accessing data is as fundamental as it gets.

#### Thoughts on sql

- never never never write a query like this
  `select * from table Where column = 'text' ORDER by id desc`;
  instead write it like this:

``` sql
select * 
from table 
where column = 'text'
order by id desc
;
```

### Python

#### Thoughts on python

- use intention-revealing names:
  in most cases `df` or `data` are terrible names for dataframes;
  be precise and specific in your naming (also for variables, function names, etc.)

### Docker

Containerising applications with Docker removes
many of the headaches around server configuration.
If the docker runs on one system, it will run on another.

- `docker build -t <name> .`:
  build a container & give it the name <name>
- `docker run <name>`: run the <name> container
  (not additional parameters like `-p`, `-d`, `--env-file`, etc.)
- `docker ps`: see a list of running docker containers
- `docker exec -it <initial_digits_of_container> sh`:
  jump inside a container & get terminal access

### Github Actions

For Continuous Delivery, we rely on Github Actions.
As one example, check [Lugha's deploy script](https://github.com/khaldoun-xyz/lugha/blob/main/.github/workflows/deploy.yml).
Whenever we merge anything into our `main` branch, the `main` branch
is automatically deployed on our Digital Ocean droplet.

### Power Point

When used properly, Microsoft Power Point is a useful tool for concept work
and to quickly visualise what you have in mind.

#### Thoughts on Power Point presentations

- if the purpose of the presentation is unclear, make it clear or cancel the presentation
- before creating slides, write down the key messages of your presentation
  (no more than 3); if they aren't clear, make them clear or cancel the presentation
- for each slide, write down its key messages (ideal is one key message);
  if the key messages aren't clear, make them clear or remove the slide
- move everything that doesn't support the key messages into the backup,
  the last section of the presentation
- whatever the time frame of your presentation, plan ~1/3 for the actual presentation
  and 2/3 for discussion

#### Power Point shortcuts

[This Youtube video](https://www.youtube.com/watch?v=-Ab-HYN0WUo) is a good primer
on the power of shortcuts in Power Point.

- `ctrl + shift + ./,` = increase/decrease font size
- `ctrl + shift + g/h` = group/ungroup selection
- `ctrl + shift + c/v` = copy/paste formatting
- `ctrl + backspace` = delete entire word
- `ctrl + mouse wheel` = zoom
- `shift + arrow keys` = increase/decrease box size
- `ctrl + mouse movement` = duplicate box
- `ctrl + shift + mouse movement` = duplicate box & move it in straight line
- `ctrl + alt + m` = create new comment
- `F4` = repeat last command
- `alt` = activate & show quick travel keys

### Plotting

Great graphs help understand the data. [This Youtube video](https://www.youtube.com/watch?v=hVimVzgtD6w&t=57s)
is very educational thanks to graphs.

#### Thoughts on great graphs

- good graphs provide easy-to-understand answers to simple qs;
  great graphs provide easy-to-understand answers to complex qs

# internal memo on important skills for Khaldoun members

Our organisations were not built by consortia or workers' councils.
Yesterday, small groups of individuals - outliers - created today's successes with highly leveraged concentrated activity.
They applied non-linear leverage to produce outsized returns because they understood that our world is governed by power laws.

The same is true today.
Therefore, the most important thing you can do is become an outlier.
Like a surfer is pushed forward by the current of the wave, you will be pushed forward by setting a higher standard for yourself.
The most effective individual or organisation does many times more with many times less than the rest.
Khaldoun is here to help you do more with less. We want you to get the basics right.
And the most basic of all basics is focus.

None of the things described below are novel or surprising. This is intended.
We want you to deeply understand the things described here.
Don't skip over parts of the document because you think you know all of this.
If you think you know everything already, let us know and we'll probe your competence.

## table of contents

- [git](#git)
- [bash](#bash)
- [terminal](#terminal)
- [sql](#sql)
- [docker](#docker)
- [power point](#power-point)
- [plotting](#plotting)

## git

Version control is a very basic and very useful tool.

### git good case practices

Below is a basic list of good case practices when using git.

- When pushing a PR, rebase to the master branch with `git rebase master`
  (make sure you have the most recent master locally!)
  and resolve any merge conflict <u>before</u> asking for review.
- When your PR isn't ready for review yet (work in progress)
  but you still want to share it with others, open the PR as `draft`.
- Squash minor git commits into fewer more relevant commits.
  Set "Squash and merge" as default merge option of branches
  (this collapses a branch with many commits into one feature commit in master).
- Where helpful, use gitmojis in your commit messages (e.g. for :bug:): <https://gitmoji.dev/>.
- Don't open PRs without descriptions.
- Once you dealt with a PR comment,
  click on "Resolve conversation" to indicate that you consider it resolved.
  Either resolve all comments or provide responses.
- Close open issues with a reference to the PRs in which they are resolved after you've resolved them.
- use at least these pre-commit hooks: end-of-file-fixer, trailing-whitespace, black, isort.
  Always make sure pre-commit hooks have run <u>before</u> asking for a review.

### git commands

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

## bash

Being able to interact with a terminal console is necessary to not be limited by GUI functionality.

- `cd ~/<path_to_folder>`: Jump into a directory.
- `ls -a`: Show all (also hidden) files in directory. (Use `ls -a -ll` for a more structured/detailed list.)
- `ctrl + r (keyboard shortcut)`: Reverse i search to find historical bash commands.
- `htop`: See cpu usage (similar to windows task manager, quit with "q").

## terminal

Add this to your .bashrc file.

### On Linux

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

### On Mac

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

## sql

Creating and accessing data is as fundamental as it gets.

### thoughts on sql queries

- never never never write a query like this "select * from table Where column = 'text' ORDER by id desc";
  instead write it like this:

```
select * 
from table 
where column = 'text'
order by id desc
;
```

## docker

Containerising applications with Docker removes many of the headaches around server configuration. If the docker runs on one system, it will run on another.

- `docker ps`: see a list of running docker containers
- `docker exec -it <initial_digits_of_container> sh`: enter a container & get terminal access

## power point

When used properly, Power Point is a useful tool for concept work and to quickly visualise what you have in mind.

### thoughts on power point presentations

- if the purpose of the presentation is unclear, make it clear or cancel presentation
- before creating slides, write down the key messages of your presentation
  (no more than 3); if they aren't clear, make them clear or cancel the presentation
- for each slide, write down its key messages (ideal is one key message); if the key
  messages aren't clear, make them clear or remove the slide
- move everything that doesn't support the key messages into the Backup,
  the last section of the presentation
- whatever the time frame of your presentation, plan ~1/3 for the actual presentation
  and 2/3 for discussion

### power point shortcuts

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

## plotting

Great graphs help understand the data. [This Youtube video](https://www.youtube.com/watch?v=hVimVzgtD6w&t=57s) is very educational thanks to graphs.

### thoughts on great graphs

- good graphs provide easy-to-understand answers to simple qs;
  great graphs provide easy-to-understand answers to complex qs

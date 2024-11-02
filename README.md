None of the things described here are novel or surprising. This is intended. <br> 
I expect you to deeply understand the things described here. 

# git
Shown below is only a subset of git commands. You'll use those a lot. 
Feel free to dive deeper into git. Just remember you're still considered a solid English speaker even if you don't know what 'transmogrify' means. 

## essential git commands
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



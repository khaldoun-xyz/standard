None of the things described here are novel or surprising. This is intended. <br> 
I expect you to deeply understand the things described here. 

# git (version control)
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


# bash (terminal interaction)
Being able to interact with a terminal console is necessary to not be limited by GUI functionality. 

- `cd ~/<path_to_folder>`: Jump into a directory.
- `ls -a`: Show all (also hidden) files in directory. (Use `ls -a -ll` for a more structured/detailed list.)
- `ctrl + r (keyboard shortcut)`: Reverse i search to find historical bash commands.
- `htop`: See cpu usage (similar to windows task manager, quit with "q").


# docker (containerised applications)
Docker removes many of the headaches around server configuration. If the docker runs on one system, it will run on another.

- `docker ps`: see a list of running docker containers
- `docker exec -it <initial_digits_of_container> sh`: enter a container & get terminal access


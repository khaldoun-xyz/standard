# Why?

- the terminal is the gateway to everything
- this is why the terminal is the primary tool of top developers & AI coding assistants

## helpful commands

- `pwd`: show current directory path
- `ls`: show contents of current directory
- `cd PATH`: switch to PATH (use tab for suggestions)
- `wc FILEPATH`: print line, word & byte count of file at FILEPATH
- `cat FILEPATH`: print file contents
- `head/tail -NUMBER`: show first/last NUMBER rows
- `grep PATTERN FILEPATH`: print the lines that match the PATTERN
- `nano/vim FILEPATH`: edit file with nano/vim in FILEPATH
- `vim FILEPATH`: edit file with vim in FILEPATH
- `mv FILEPATH TARGETFOLDER`: move file from FILEPATH to TARGETFOLDER
- `CTRL + r`: search through your bash history
- `tree`: shows your worktree (requires installation)
- `ncdu`: show your data storage from the current folder (requires installation)
- `btop`: show hardware performance metrics (requires installation)
- `lscpu`: see the hardware specifications of your CPU
- `sqlite3 CONNECTIONSTRING`: connect to a SQLite database from the terminal
- `psql CONNECTIONSTRING`: connect to a postgreSQL database from the terminal
- `screen`: start a new virtual screen window
  ([cheatsheet](https://gist.github.com/jctosta/af918e1618682638aa82))
- `tmux`: start a new virtual tmux window
  ([cheatsheet](https://gist.github.com/MohamedAlaa/2961058))
- `lazygit`: show your current git changes in lazygit
- `ping URL`: checks liveness of URL
- `curl URL`: send a request to URL

## generally helpful

- use `|` to combine commands, e.g. `cat FILEPATH | head 5` to show
  the first 5 rows in a file
- use `man COMMAND` to read the manual for the command, e.g. `man wc`.
  - alternatively, run `COMMAND --help`
- set global configurations in your `~/.bashrc` file.
  - e.g. aliases (`alias YOURALIAS='COMMAND'`) or `psql` connections
- beautify your output of your `psql` queries with a `~/.psqlrc` file

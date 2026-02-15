# why use the terminal?

- be faster
- to not overengineer things
- to be focused
- certain things don't have GUIs

## helpful commands

- ls - show contents of current directory
- pwd - show current directory path
- cd - change directory
- mv - move file
- `cat` - print file contents
- head/tail -n: show first/last n rows
- `less` - open file in terminal window & exit with `q`
  - you can search files using `/`
- search your bash history: `CTRL + r`, confirm with ENTER
- `sudo apt upgrade && sudo apt update` (only on Ubuntu)

### piping (string commands together)

- get all rows that contain "docker": cat README.md | grep docker
- count number of files/folders in directory: ls | wc -l
- cat README.md | head -5 (alternative: head -5 README.md)

### whatever commands (more complicated)

- `scp`: copy files to a server
- `history`: show your bash history
- `man BASHCOMMAND`: show manual of bash command

## virtual terminal windows (esp. tmux, screen)

### why?

- enables remote jobs (e.g. on a server)
  - direct terminal commands only run as long
    as the terminal connection to the server persists

### screen

- start a new screen with `screen` or `screen -S NAME`
- detach from the screen with `CTRL + a + d`
- list all existing screens with `screen -ls`
- reattach to a screen with `screen -r NAME` or `screen -r ID`

## aliases

- add `alias YOURALIAS='COMMAND'` to your `.bashrc` file

## database operations

- set up an alias for `psql`
- set up a `.psqlrc` file to beautify your output

## editors

- nano, vim

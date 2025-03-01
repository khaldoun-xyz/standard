# Initial set up to get going quickly

This repo contains an installer script that sets up Khaldoun's
recommended configurations and development tools.

## Install

Execute in this sequence:

- clone this repo and navigate to the folder `setup`
- run `. khaldoun-setup.sh`

## .bashrc

- add this to the bottom of your `~/.bashrc`:

```bash
# --------------------------- manually add to .bashrc --------------------------------
# show git branch in Terminal
function parse_git_branch() {
  git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
RED="\[\033[01;31m\]"
YELLOW="\[\033[01;33m\]"
GREEN="\[\033[01;32m\]"
BLUE="\[\033[01;34m\]"
NO_COLOR="\[\033[00m\]"
PS1="$GREEN\u$NO_COLOR:$BLUE\w$YELLOW\$(parse_git_branch)$NO_COLOR\$ "

# add venv aliases
alias lugha='cd ~/programming/lugha && . ~/virtualenvs/lugha/bin/activate'
alias renard='cd ~/programming/renard && . ~/virtualenvs/renard/bin/activate'
alias sisu='cd ~/programming/sisu && . ~/virtualenvs/sisu/bin/activate'
alias terminal_llm='cd ~/programming/terminal_llm/src && . ~/virtualenvs/terminal_llm/bin/activate && python chat.py'
alias khaldoun='cd ~/programming/khaldoun && . ~/virtualenvs/khaldoun/bin/activate'

# add neovim alias
alias n='~/programming/nvim-linux-x86_64.appimage'
```

## LazyVim Extras

- In LazyVim, type `:LazyExtras` to open the plugin manager.
  Navigate to these plugins and press x at each one to select it for installation:
  - `lang.markdown`, `lang.python`, `lang.docker`,
    `lang.sql`, `lang.yaml`, `lang.json`, `lang.terraform`  
  - To get `lang.python` to work properly, you'll need to insert this line
    into `~/.config/nvim/lua/config/options.lua`: `vim.g.lazyvim_python_lsp = "basedpyright"`.
- Close and re-open LazyVim.

## Troubleshooting LazyGit

- If LazyGit crashes with this error msg: 
  `stat /home/USER/.config/lazygit/config.yml: no such file or directory`, 
  simply create an empty config.yml file in the requested location.

## Troubleshooting hardware

- if your wifi is not available, follow these steps:
  <https://askubuntu.com/questions/55868/installing-broadcom-wireless-drivers>
- if your webcam is not available, follow the Debian steps:
  <https://github.com/patjak/facetimehd/wiki/Installation#get-started-on-debian>

sudo apt update -y
sudo apt upgrade -y

sudo apt-get install snapd -y # snap store
sudo apt install python3-pip -y
sudo apt install postgresql -y
sudo apt install sqlite3 -y
sudo apt install tmux -y
sudo apt install docker-compose -y
sudo apt install docker.io -y
sudo usermod -aG docker $USER # run this to not require sudo for docker commands
# newgrp docker
sudo apt install alacritty -y
sudo snap install zellij --classic
sudo apt install ripgrep -y # for finding files based on words
sudo apt-get install gnome-screenshot -y
sudo apt-get install gthumb -y
sudo apt install htop -y
sudo apt-get install cheese -y
sudo apt install python3.10-venv -y # necessary for certain Lazyvim Mason installs
sudo pip3 install virtualenv
sudo apt install pre-commit -y
sudo apt reinstall --purge bluez gnome-bluetooth -y # to preempt headphone issues
sudo apt install chromium-chromedriver -y           # for selenium testing

mkdir ~/virtualenvs
mkdir ~/programming/
cd ~/programming/

git config --global credential.helper store

## khaldoun
# lugha
git clone https://github.com/khaldoun-xyz/lugha.git
virtualenv ~/virtualenvs/lugha
. ~/virtualenvs/lugha/bin/activate
pip install -r lugha/requirements.txt
# sisu
git clone https://github.com/khaldoun-xyz/sisu.git
virtualenv ~/virtualenvs/sisu
. ~/virtualenvs/sisu/bin/activate
pip install -r sisu/requirements.txt
# terminal_llm
git clone https://github.com/khaldoun-xyz/terminal_llm.git
virtualenv ~/virtualenvs/terminal_llm
. ~/virtualenvs/terminal_llm/bin/activate
pip install -r terminal_llm/requirements.txt
# renard
git clone https://github.com/khaldoun-xyz/renard.git
virtualenv ~/virtualenvs/renard
. ~/virtualenvs/renard/bin/activate
pip install -r renard/requirements.txt
# core_skills
git clone https://github.com/khaldoun-xyz/core_skills.git
# khaldoun hp
git clone https://github.com/khaldoun-xyz/khaldoun.git
virtualenv ~/virtualenvs/khaldoun
. ~/virtualenvs/khaldoun/bin/activate
pip install -r khaldoun/requirements.txt
deactivate

# neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git
# lazygit for neovim
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
rm -rf lazygit.tar.gz
# lazydocker
LAZYDOCKER_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazydocker/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazydocker.tar.gz "https://github.com/jesseduffield/lazydocker/releases/latest/download/lazydocker_${LAZYDOCKER_VERSION}_Linux_x86_64.tar.gz"
mkdir lazydocker-temp
tar xf lazydocker.tar.gz -C lazydocker-temp
sudo mv lazydocker-temp/lazydocker /usr/local/bin
rm -rf lazydocker.tar.gz lazydocker-temp
# install fonts for alacritty to show nvim icons properly
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.zip
unzip FiraCode.zip -d ~/.local/share/fonts
rm FiraCode.zip
fc-cache -fv
mkdir ~/.config/alacritty/
cat <<EOF >>~/.config/alacritty/alacritty.yml
font:
  normal:
    family: "FiraCode Nerd Font"
    size: 12.0
  bold:
    family: "FiraCode Nerd Font"
  italic:
    family: "FiraCode Nerd Font"
env:
  LANG: en_US.UTF-8
EOF
# for LazyVim plugins
sudo apt install npm -y                                                         # to install markdownlint-cli2
sudo npm install markdownlint-cli2 --global -y                                  # for lazyvim markdownlinting
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash # nvm for node js
nvm install --lts                                                               # update node js
sudo pip install mypy-django                                                    # for python linting

# install brave
sudo apt install apt-transport-https curl
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt install brave-browser -y

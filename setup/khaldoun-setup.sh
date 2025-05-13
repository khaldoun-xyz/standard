#!/bin/bash

# Simple setup script with configurable name and email

# Prompt for name and email
read -p "Enter your name for Git: " NAME
read -p "Enter your email: " EMAIL

# Update system
sudo apt update -y
sudo apt upgrade -y

# Install pipx
sudo apt install pipx -y
pipx ensurepath

# Generate SSH key
ssh-keygen -t ed25519 -C "$EMAIL"

# Start SSH agent and add key
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

# Display public key
cat ~/.ssh/id_ed25519.pub
echo "Copy the above key to your GitHub"
echo "Press Enter to continue..."
read

# Configure Git
git config --global user.name "$NAME"
git config --global user.email "$EMAIL"

mkdir -p ~/programming/
cd ~/programming/

# Clone repositories
git clone git@github.com:khaldoun-xyz/lugha.git
cd lugha
pipx install --include-deps --pip-args="-r requirements.txt" .
cd ..

git clone git@github.com:khaldoun-xyz/sisu.git
cd sisu
pipx install --include-deps --pip-args="-r requirements.txt" .
cd ..

git clone git@github.com:khaldoun-xyz/terminal_llm.git
cd terminal_llm
pipx install --include-deps --pip-args="-r requirements.txt" .
cd ..

git clone git@github.com:khaldoun-xyz/renard.git
cd renard
pipx install --include-deps --pip-args="-r requirements.txt" .
cd ..

git clone git@github.com:khaldoun-xyz/core_skills.git

git clone git@github.com:khaldoun-xyz/khaldoun.git
cd khaldoun
pipx install --include-deps --pip-args="-r requirements.txt" .
cd ..

# Install aider
pipx install aider-chat

sudo apt update -y
sudo apt upgrade -y


#install pipx to avoid issues and relaunch(safest option)
sudo apt install pipx

ssh-keygen -t ed25519 -C "your-email@example.com"
# Start the SSH agent
eval "$(ssh-agent -s)"

ssh-add ~/.ssh/id_ed25519

cat ~/.ssh/id_ed25519.pub
echo "Copy the above key to your Git provider (GitHub/GitLab/etc.)"
echo "Then press Enter to continue..."
read

# Set up Git with your info
git config --global user.name "Your Name"
git config --global user.email "your-email@example.com"

# Install pipx for managing Python tools in isolated environments
sudo apt install pipx -y
pipx ensurepath

# Replace virtualenv usage with pipx for the projects
mkdir -p ~/programming/
cd ~/programming/

## Clone repositories using SSH instead of HTTPS
# Configure each repo with pipx instead of virtualenv

# lugha
git clone git@github.com:khaldoun-xyz/lugha.git
cd lugha
pipx install --include-deps --pip-args="-r requirements.txt" .
cd ..

# sisu
git clone git@github.com:khaldoun-xyz/sisu.git
cd sisu
pipx install --include-deps --pip-args="-r requirements.txt" .
cd ..

# terminal_llm
git clone git@github.com:khaldoun-xyz/terminal_llm.git
cd terminal_llm
pipx install --include-deps --pip-args="-r requirements.txt" .
cd ..

# renard
git clone git@github.com:khaldoun-xyz/renard.git
cd renard
pipx install --include-deps --pip-args="-r requirements.txt" .
cd ..

# core_skills
git clone git@github.com:khaldoun-xyz/core_skills.git

# khaldoun hp
git clone git@github.com:khaldoun-xyz/khaldoun.git
cd khaldoun
pipx install --include-deps --pip-args="-r requirements.txt" .
cd ..

# Install aider with pipx instead of pip
pipx install aider-chat


#!/bin/zsh

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Update Homebrew and install packages
brew update

# Install Zsh if not already installed
if ! command_exists zsh; then
    brew install zsh
fi

# Change default shell to Zsh if it's not already
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s $(which zsh)
fi

# Install Oh My Zsh if not already installed
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install vim and tig if not already installed
if ! command_exists vim; then
    brew install vim
fi

if ! command_exists tig; then
    brew install tig
fi

# Set up Oh My Zsh custom directory
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# Install Powerlevel10k theme
if [ ! -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
fi

# Install zsh-autosuggestions plugin
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
fi

# Install zsh-syntax-highlighting plugin
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
fi

# Install zsh-256color plugin
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-256color" ]; then
    git clone https://github.com/chrissicool/zsh-256color $ZSH_CUSTOM/plugins/zsh-256color
fi

# Install gitfast plugin
if [ ! -d "$ZSH_CUSTOM/plugins/gitfast" ]; then
    git clone https://github.com/ohmyzsh/ohmyzsh.git $ZSH_CUSTOM/plugins/gitfast
fi

# Update .zshrc to use the plugins and Powerlevel10k theme
sed -i '' 's/^ZSH_THEME=.*/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
sed -i '' 's/^plugins=.*/plugins=(git gitfast zsh-autosuggestions zsh-syntax-highlighting zsh-256color)/' ~/.zshrc

# Source .zshrc to apply changes
source ~/.zshrc

echo "Installation and setup complete!"

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="funky"

if [ -e ~/.profile_local ]; then source ~/.profile_local; fi
source $ZSH/oh-my-zsh.sh

# Customize to your needs...

# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="eastwood"

plugins=(battery brew emacs git heroku history osx)

[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

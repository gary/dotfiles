if [ $EMACS ]; then export TZ='America/New_York'; fi

export CDPATH=.:$HOME/apps

export PATH=$HOME/bin:$PATH
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/.rbenv/shims:$PATH"

export BREWS="$HOME/.dotfiles/../brews"
export CASKS="$HOME/.dotfiles/../casks"
export GEMS="$HOME/.dotfiles/../gems"
export PIPS="$HOME/.dotfiles/../pips"

export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="kolo"

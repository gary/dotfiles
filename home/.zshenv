if [ $EMACS ]; then export TZ='America/New_York'; fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$HOME/.cargo/bin:$PATH"
export CDPATH=.:$HOME/src:$HOME/work:$HOME/src/work/
export GOPATH="$HOME/src/go"
export PATH=$HOME/.rbenv/bin:$PYENV_ROOT/bin:.bundle/binstubs:$HOME/bin:$PATH

export GEMS="$HOME/.dotfiles/../gems"
export TAPAS="${HOME}/src/rubytapas"

export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="mgutz"

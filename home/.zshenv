export PATH=$HOME/bin:$PATH

if [ $EMACS ]; then export TZ='America/New_York'; fi

if [ -h ~/repos ]; then REPOS="$HOME/repos"; fi

export CDPATH=$HOME/src:$HOME/work:$HOME/src/work/

export RBENV_ROOT=/usr/local/var/rbenv
eval "$(rbenv init -)"

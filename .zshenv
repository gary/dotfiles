export PATH=$PATH:$HOME/bin

if [ $EMACS ]; then export TZ='America/New_York'; fi

if [ -h ~/repos ]; then REPOS="$HOME/repos"; fi

export CDPATH=$HOME/src:$HOME/work:$HOME/src/work/

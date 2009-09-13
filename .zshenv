export PATH=$HOME/bin:$HOME/.gem/ruby/1.8/bin/:$PATH

if [ $EMACS ]; then export TZ='America/New_York'; fi

if [ -h ~/repos ]; then REPOS="$HOME/repos"; fi

export CDPATH=$HOME/src:$HOME/work:$HOME/src/work/

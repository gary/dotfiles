if [ $EMACS ]; then export TZ='America/New_York'; fi

export CDPATH=.:$HOME/src:$HOME/work:$HOME/src/work/

[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh

export PATH=.bundle/binstubs:$HOME/bin:$PATH

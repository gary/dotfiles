if [ -n "$INSIDE_EMACS" ]
then
    # directory tracking
    chpwd() { print -P "\033AnSiTc %d" }
    print -P "\033AnSiTu %n"
    print -P "\033AnSiTc %d"
fi

plugins=(battery brew emacs git heroku history osx)

[ -f /opt/boxen/env.sh ] && source /opt/boxen/env.sh

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

if [ -n "$INSIDE_EMACS" ]
then
    # directory tracking
    chpwd() { print -P "\033AnSiTc %d" }
    print -P "\033AnSiTu %n"
    print -P "\033AnSiTc %d"
fi

plugins=(
    battery bundler brew
    common-aliases
    emacs
    fastfile
    git
    heroku history
    osx
)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

unalias cp
unalias mv
unalias rm

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
eval "$(hub alias -s)"
eval "$(rbenv init -)"

if [ -f ~/.servers ]; then
    source ~/.servers
fi

if [ -f ~/.profile_local ]; then
    source ~/.profile_local
fi

if [ -f ~/.bash_vars ]; then
    source ~/.bash_vars
fi

if [ -f ~/.bash_path ]; then
    source ~/.bash_path
fi

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

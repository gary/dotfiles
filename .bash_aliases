#-*-mode:shell-script;-*-
##################################################
# Fancy PWD display function
##################################################
# The home directory (HOME) is replaced with a ~
# The last pwdmaxlen characters of the PWD are displayed
# Leading partial directory names are striped off
# /home/me/stuff          -> ~/stuff               if USER=me
# /usr/share/big_dir_name -> ../share/big_dir_name if pwdmaxlen=20
##################################################
bash_prompt_command() {
	# How many characters of the $PWD should be kept
	local pwdmaxlen=25
	# Indicate that there has been dir truncation
	local trunc_symbol=".."
	local dir=${PWD##*/}
	pwdmaxlen=$(( ( pwdmaxlen < ${#dir} ) ? ${#dir} : pwdmaxlen ))
	NEW_PWD=${PWD/#$HOME/~}
	local pwdoffset=$(( ${#NEW_PWD} - pwdmaxlen ))
	if [ ${pwdoffset} -gt "0" ]
	then
		NEW_PWD=${NEW_PWD:$pwdoffset:$pwdmaxlen}
		NEW_PWD=${trunc_symbol}/${NEW_PWD#*/}
	fi
}

bash_prompt() {
	local NONE='\[\033[0m\]'    # unsets color to term's fg color

	# regular colors
	local K='\[\033[0;30m\]'    # black
	local R='\[\033[0;31m\]'    # red
	local G='\[\033[0;32m\]'    # green
	local Y='\[\033[0;33m\]'    # yellow
	local B='\[\033[0;34m\]'    # blue
	local M='\[\033[0;35m\]'    # magenta
	local C='\[\033[0;36m\]'    # cyan
	local W='\[\033[0;37m\]'    # white

	# empahsized (bolded) colors
	local EMK='\[\033[1;30m\]'
	local EMR='\[\033[1;31m\]'
	local EMG='\[\033[1;32m\]'
	local EMY='\[\033[1;33m\]'
	local EMB='\[\033[1;34m\]'
	local EMM='\[\033[1;35m\]'
	local EMC='\[\033[1;36m\]'
	local EMW='\[\033[1;37m\]'

	# background colors
	local BGK='\[\033[40m\]'
	local BGR='\[\033[41m\]'
	local BGG='\[\033[42m\]'
	local BGY='\[\033[43m\]'
	local BGB='\[\033[44m\]'
	local BGM='\[\033[45m\]'
	local BGC='\[\033[46m\]'
	local BGW='\[\033[47m\]'

	local UC=$EM # user's color
	local MC=$EMC
	[ $UID -eq "0" ] && UC=$R # root's color

	# backslash in front of \$ to make bash colorize the prompt
    # multi line
	#PS1="${EMW}${UC}\u${EMW}@${MC}\h ${Y}\${NEW_PWD}\n${EMW}${BGR}\!${BGK}|${BGM}\#${BGK}${G} \\$ ${NONE}"
    # single line
	PS1="${EMW}${BGR}|\#|${NONE} ${BGY}${EMK}${UC}\h${NONE}${BGB}${W}\$(__git_ps1)\$(parse_svn_branch)${Y} ${BGK}${G}\\$ ${NONE}"
}

PROMPT_COMMAND=bash_prompt_command
bash_prompt
unset bash_prompt

function authme {
    ssh $1 'cat >>.ssh/authorized_keys' <~/.ssh/id_dsa.pub 
}

function parse_svn_branch() {
    parse_svn_url | sed -e 's#^'"$(parse_svn_repository_root)"'##g' | awk -F / '{print "(svn::"$1 "/" $2 ")"}'
}
function parse_svn_url() {
    svn info 2>/dev/null | grep -e '^URL*' | sed -e 's#^URL: *\(.*\)#\1#g '
}
function parse_svn_repository_root() {
    svn info 2>/dev/null | grep -e '^Repository Root:*' | sed -e 's#^Repository Root: *\(.*\)#\1\/#g '
}

function pless {
    pygmentize $1 | less -r
}

# dir specific ls
alias lsd='find . -maxdepth 1 -type d'
alias ls='ls -pG'
alias ll='ls -l'
alias lt='ll -t'
alias la='ll -a'
alias l='ll | less'

# getting around faster
alias cdu='cd ..'

alias dirs='dirs -v'
alias pd='pushd'
alias po='popd'
for ((n = 2; n < 10; n++))
do
    alias pd$n="pushd +$n"
    alias po$n="popd +$n"
    i=1
    parentdir=../
    until [ "$i" -eq "$n" ]
    do
        parentdir="${parentdir}../"
        i=`expr $i + 1`
    done
    alias cdu$n="cd $parentdir"
done

# TODO: research and migrate to profile_local accordingly
alias ps='ps aux'
alias psc='ps c'

alias rl='readlink'

if [ `which ack` ]; then
    alias ack='ack --group'
fi

if [ -z $EMACS ]; then
	alias grep='grep --color=always'
    if [ `which ack` ]; then
        alias ack='ack --group --color'
    fi
fi

if [ -e /usr/bin/ruby ]; then
    # TODO: use shell aliases if not in emacs; yasnippets otherwise
    alias irb='irb -r irb/completion -r rubygems'
    alias rdb='ruby -r debug'
    alias gs='gem search '
    alias gi='gem install '
    alias gli='gem install --install-dir $HOME/.gems'
    alias gl='gem list '
    alias spec='spec -c -f specdoc'
fi

if [ `which git` ]; then
    if [ -f ~/.git-completion.sh ]; then
        source ~/.git-completion.sh
    fi
    alias gb='git branch -a -v'
    alias gs='git status'
    alias gd='git diff'

    # gc      => git checkout master
    # gc bugs => git checkout bugs
    function gc {
        if [ -z "$1" ]; then
            git checkout master
        else
            git checkout $1
        fi
    }
fi

# Set up aliases for all known hosts, so that you can type just the
# name of the host to ssh to it.  This in combination with keypair
# authentication allows for some really quick work:
# $ mcsmos01 grep failed /var/log/httpd/error_log | more
for FILE in "$HOME"/.ssh/known_hosts "${HOME}"/.ssh/known_hosts2
do
    if [ -r "$FILE" ]
    then
        for i in `< "$FILE" awk '{print $1}' | tr , ' '`; do
            if ! type -p $i > /dev/null; then
                alias "$i"="ssh gary@$i"
            fi
        done
    fi
done

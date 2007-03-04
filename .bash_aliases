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

	local UC=$EMG                 # user's color
	local MC=$EMB
	[ $UID -eq "0" ] && UC=$R   # root's color

	# emacs doesn't like colorful prompts
	if [ -z $EMACS ]; then
	     	# backslash in front of \$ to make bash colorize the prompt
		PS1="${EMW}${UC}\u${EMW}@${MC}\h ${Y}\${NEW_PWD}\n${EMW}${BGR}\!${BGK}|${BGM}\#${BGK}${G} \\$ ${NONE}"
	else
		PS1="\u@\h \w\n\!|\# \\$ "
	fi
}

# resetvisor() {
#     defaults write com.apple.Terminal VisorTerminal -dict-add Rows 20
#     ~/bin/visor &
#     killall Terminal
# }

PROMPT_COMMAND=bash_prompt_command
bash_prompt
unset bash_prompt

irb='irb -r irb/completion -r rubygems'
alias rdb='ruby -r debug'

if [ -z $EMACS ]; then
	alias grep='grep --color=always'
fi

# dir specific ls
alias lsd='ls **/ | Egrep "\/:$" | tr -d ":"'
# colorful directory listing
alias ll='ls -Gl'
alias ls='ls -G'
alias la='ls -Gla'
alias l='ls -Gl | less'

# resolve ' escape issue
# alias cps=`ps aux | awk '$3 != "0.0"'`

# getting around faster
alias dirs='dirs -v'
alias pd='pushd'
alias pd2='pushd +2'
alias pd3='pushd +3'
alias pd4='pushd +4'
alias pd5='pushd +5'

alias po='popd'
alias po2='popd +2'
alias po3='popd +3'
alias po4='popd +4'
alias po5='popd +5'

if [ -f ~/bin/itunes ]; then
   # iTunes cli hack
   alias play="itunes play"
   alias pause="itunes pause"
   alias next="itunes next"
   alias prev="itunes prev"
   alias cur="itunes status"
   #alias restart="itunes pause prev next"
fi

if [ -d ~/.Trash ]; then
   alias ts='du -h -d0 $HOME/.Trash'
fi

if [ $CFGFILES ]; then
   alias cicfg='svn commit $CFGFILES'
fi

if [ -d /Applications/Aquamacs\ Emacs.app/ ]; then
   alias aquamacs='open -a /Applications/Aquamacs\ Emacs.app/'
fi

#######################
# custom prompt
#######################
set hostname=`hostname -s`
alias setprompt 'set prompt="\\
%B%n@%m%b:${cwd}\\
%S%B \! %b%s % "'
alias cd 'chdir \!* && setprompt'
setprompt	# to set the initial prompt

#exec screen
# ------------ screen setup --------------
alias php5	'/usr/local/php5/bin/php' # allowing separate access to php5 via cli
#alias gvim	'/Users/sm41Eg01/bin/gvim' # launch gvim from the command line
alias ls        'lsc --color'     #set the color on in the color ls program
alias l 	'lsc --color -lg'
alias ll	'lsc --color -lag \!* | more'
#alias onCampus 'ssh giams@134.53.131.180'

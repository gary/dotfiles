# darwin ports, containing more up-to-date versions of select binaries
export PATH="/opt/local/bin:$PATH";
# custom scripts, etc.
export PATH="$PATH:$HOME/bin";

export EDITOR=`which vim`

#ignore duplicate history entries
export HISTCONTROL=ignoreboth;

# easy access to the various svn repositories
repos="$HOME/repos"

# now source bash-specific commands
source .bashrc

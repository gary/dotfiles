#!/usr/bin/sh

cd $HOME;
if [ -z $REPOS ]; then
    return 0
fi

if ! [ -d $CFGFILES ]; then
    svn ci file://$REPOS/config .config
fi

# cl apps
for cfg in *_* *rc .emacs;
do
    ln -s $CFGFILES/$cfg $cfg
done

if [ -d /Applications/Aquamacs\ Emacs.app ]; then
# aquamacs
    for aqCfg in *.el;
    do
	ln -s $CFGFILES/$aqCfg ~/Library/Aquamacs\ Emacs/$aqCfg
    done
fi
#!/bin/bash
set -e 

#
# Backup Directory
#
if [[ ! -d ~/.bak ]]; then
    mkdir ~/.bak
else
    echo "Directory ~/.bak exists, please remove before running."
    echo "Exiting..."
    exit 1
fi

_backup_and_replace() {
    if [[ -f $1/.$2 ]]; then
        mv $1/.$2 ~/.bak
    fi
    ln -s ~/dots/$2 $1/.$2
}

#
# RC Files
#
# ~
for i in bashrc inputrc vimrc
do
    _backup_and_replace ~ $i
done

# .config
# TODO better way to do this?
[[ ! -d ~/.config/xfce4/terminal ]] && mkdir -p ~/.config/xfce4/terminal
# TODO this isn't currently a symlink?
[[ -f ~/.config/xfce4/terminal/.terminalrc ]] && mv ~/.config/xfce4/terminal/.terminalrc ~/.bak
cp ~/dots/terminalrc ~/.config/xfce4/terminal/.terminalrc

#
# Git Files
#
for i in gitconfig gitignore_global
do
    _backup_and_replace ~ $i
done

#
# Citrix Reciever
#
[[ ! -d ~/.ICAClient ]] && mkdir ~/.ICAClient

rm -f ~/.ICAClient/All_Regions.ini
ln -s ~/dots/ ~/.ICAClient/All_Regions.ini

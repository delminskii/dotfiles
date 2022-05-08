#!/bin/bash

GITHUB_SSHKEY="$HOME/.ssh/github_dotfiles"

BACKUP_FOLDER="$HOME/.dotfiles"
BACKUP_LOGFILE="$HOME/.backup_configs.log"
BACKUPING_FILES="/etc/default/keyboard
$HOME/.bashrc
$HOME/.vimrc
$HOME/.conkyrc
$HOME/.dircolors
$HOME/.Xresources
$HOME/.config/openbox/*
$HOME/scripts/*
$HOME/.config/nvim/*
$HOME/.vim/user_snippets/python.snippets
$HOME/.config/mpv/mpv.conf
$HOME/.radios.txt
$HOME/.xinitrc
$HOME/.bash_aliases
$HOME/.lessrc
$HOME/.tmux.conf
$HOME/.gitconfig
$HOME/.gitignore
$HOME/.config/tint2/tint2rc
$0
"

echo "Date: $(date)" >>$BACKUP_LOGFILE
for file in $BACKUPING_FILES
do
    if [ -e $file ]
    then
        dest_dir=$BACKUP_FOLDER
        if [[ $file == *"openbox"* ]]
        then
            dest_dir="$BACKUP_FOLDER/openbox"
        elif [[ $file == *"scripts"* ]]
        then
            dest_dir="$BACKUP_FOLDER/scripts"
        else
            echo "file: '$file'"
        fi
        cp $file $dest_dir
        echo "$file is backuped." >>$BACKUP_LOGFILE
    else
        echo "ERROR: $file isn't backuped." >>$BACKUP_LOGFILE
    fi
done

# github push
eval `ssh-agent -s`
ssh-add $GITHUB_SSHKEY
cd $BACKUP_FOLDER
git add .
git commit -m "Backuped by cron"
git push -u origin master

msg="ERROR: Can't back up to github."
if [[ $(git status) == *"nothing to commit"* ]]
then
    msg="Backuped to github."
fi
echo $msg >>$BACKUP_LOGFILE
echo "======================================================" >>$BACKUP_LOGFILE

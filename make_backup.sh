#!/usr/bin/bash

GITHUB_SSHKEY="$HOME/.ssh/github_key"

BACKUP_FOLDER="$HOME/.dotfiles"
BACKUP_LOGFILE="$HOME/.backup_configs.log"
BACKUPING_FILES="/etc/default/keyboard
$HOME/.bashrc
$HOME/.dir_colors
$HOME/.vimrc
$HOME/.conkyrc
$HOME/.Xresources
$HOME/.config/openbox/*
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
        fi
        cp $file $dest_dir
        echo "$file is backuped." >>$BACKUP_LOGFILE
    else
        echo "ERROR: $file isn't backuped." >>$BACKUP_LOGFILE
    fi
done

# github push
ssh-add $GITHUB_SSHKEY
cd $BACKUP_FOLDER
git add -A
git commit -m "Backuped by cron"
git push -u origin master

msg="ERROR: Can't back up to github."
if [[ $(git status) == *"nothing to commit"* ]]
then
    msg="Backuped to github."
fi
echo $msg >>$BACKUP_LOGFILE
echo "======================================================" >>$BACKUP_LOGFILE

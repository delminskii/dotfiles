#!/usr/bin/bash

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

echo "Date: $date" >>$BACKUP_LOGFILE
for file in $BACKUPING_FILES
do
    if [ -e $file ]
    then
        dest_dir=$BACKUP_FOLDER
        echo $file
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
cd $BACKUP_FOLDER
git commit -m "Backuped"
git push -u origin master
if [[ $(git status) == *"nothing to commit"* ]]
then
    echo "Backuped to github." >>$BACKUP_LOGFILE
    echo "KEK"
fi
echo "======================================================" >>$BACKUP_LOGFILE

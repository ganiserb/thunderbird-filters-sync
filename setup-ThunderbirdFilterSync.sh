#!/bin/bash

TB_PROFILE=/home/gabriel/.thunderbird/ThunderbirdProfile
SYNC_STASH=/home/gabriel/Dropbox/Sistema/ThunderbirdSync

for accountDir in $(ls -1p $TB_PROFILE$'/ImapMail' | grep "/")
do  # accountDir has a trailing slash: account1/
    accountName=${accountDir%/}
    cd $TB_PROFILE$'/ImapMail' # Move to Profile > ImapMail
    
    accountStash=$SYNC_STASH$"/"$accountName

    mkdir -p $accountStash$"/"
    cp $accountName$"/msgFilterRules.dat" $accountStash$"/"
    mv $accountName$"/msgFilterRules.dat" $accountName$"/msgFilterRules.dat.backup"
    
    ln -s $accountStash$"/msgFilterRules.dat" $accountName$"/"msgFilterRules.dat
done

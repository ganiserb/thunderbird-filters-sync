#!/bin/bash

TB_PROFILE="$1"
SYNC_STASH="$2"

if [ "$3" = "restore" ]; then
	for accountDir in $(ls -1p $TB_PROFILE$'/ImapMail' | grep "/");	do
		# accountDir has a trailing slash: account1/
		accountName=${accountDir%/}
		
		cd $TB_PROFILE$'/ImapMail' # Move to Profile > ImapMail
		
		accountStash=$SYNC_STASH$"/"$accountName

		rm $accountName$"/msgFilterRules.dat"	# The (supposed) symlink
		cp $accountName$"/msgFilterRules.dat.backup" $accountName$"/msgFilterRules.dat"
	done

elif [ "$3" = "update" ]; then

	exit

else
	for accountDir in $(ls -1p $TB_PROFILE$'/ImapMail' | grep "/");	do
		# accountDir has a trailing slash: account1/
		accountName=${accountDir%/}
		
		cd $TB_PROFILE$'/ImapMail' # Move to Profile > ImapMail
		
		accountStash=$SYNC_STASH$"/"$accountName

		mkdir -p $accountStash$"/"
		cp $accountName$"/msgFilterRules.dat" $accountStash$"/"
		mv $accountName$"/msgFilterRules.dat" $accountName$"/msgFilterRules.dat.backup"
		
		ln -s $accountStash$"/msgFilterRules.dat" $accountName$"/"msgFilterRules.dat
	done
fi

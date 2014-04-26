#!/bin/bash

# Usage:
# 	script.sh <absolute_thunderbird_profile_path> <absolute_sync_dir_path> [restore|link]
#	
#	If the script is called without a third parameter, it will asume this is
#		the first time the links are being set up and will replace all existing
#		files inside the sync_dir
#	If called wit the "restore" parameter, the script will restore the backup files inside
#		the thunderbird_profile created when the script was first run, and leave the files
#		inside the sync_dir untouched
#	"link" currently does nothing but should link to an existing stash inside the sync_dir
#

# Both parameters WITHOUT trailing slash
TB_PROFILE="$1" # Full path to your Thunderbird profile folder
SYNC_STASH="$2" # Full path to your Synced folder (ie: Dropbox) where to put the filter rules

if [ "$3" = "restore" ]; then
	# 
	
	for accountDir in $(ls -1p $TB_PROFILE/ImapMail | grep "/");	do
		# accountDir has a trailing slash: account1/
		accountName=${accountDir%/}
		
		cd $TB_PROFILE/ImapMail # Move to Profile > ImapMail
		
		accountStash=$SYNC_STASH"/"$accountName

		rm $accountName"/msgFilterRules.dat"	# The (supposed) symlink
		cp $accountName"/msgFilterRules.dat.backup" $accountName"/msgFilterRules.dat"
	done

elif [ "$3" = "link" ]; then

	for accountDir in $(ls -1p $TB_PROFILE/ImapMail | grep "/");	do
		# accountDir has a trailing slash: account1/
		accountName=${accountDir%/}
		
		cd $TB_PROFILE'/ImapMail' # Move to Profile > ImapMail
		
		accountStash=$SYNC_STASH"/"$accountName

		#mkdir -p $accountStash$"/"
		#cp $accountName$"/msgFilterRules.dat" $accountStash$"/"
		mv $accountName"/msgFilterRules.dat" $accountName"/msgFilterRules.dat.backup"
		
		ln -s $accountStash"/msgFilterRules.dat" $accountName"/msgFilterRules.dat"
	done

else
	for accountDir in $(ls -1p $TB_PROFILE/ImapMail | grep "/");	do
		# accountDir has a trailing slash: account1/
		accountName=${accountDir%/}
		
		cd $TB_PROFILE'/ImapMail' # Move to Profile > ImapMail
		
		accountStash=$SYNC_STASH"/"$accountName

		mkdir -p $accountStash"/"
		cp $accountName"/msgFilterRules.dat" $accountStash"/"
		mv $accountName"/msgFilterRules.dat" $accountName"/msgFilterRules.dat.backup"
		
		ln -s $accountStash"/msgFilterRules.dat" $accountName"/msgFilterRules.dat"
	done
fi

#!/bin/bash
#set -ex # Prints each command

declare -A ServiceCommands=( \
["DRIVE"]="insync start" \
["DROPBOX"]="dropbox start" \
)

if [ ! $1 ] # If called with no input
then
	echo "Starting all services"
	for com in "${ServiceCommands[@]}"
	do
		echo $com
		eval $com &
	done
else
	echo "Searching for matching services"
	for com in "${!ServiceCommands[@]}" # Checks keys
	do
		if [ "$com" = "$1" ]
		then
			echo ${ServiceCommands[$com]}
			eval ${ServiceCommands[$com]} &
		fi
	done
fi

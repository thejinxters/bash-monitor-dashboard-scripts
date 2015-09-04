#!/bin/bash

# Get Percentage from DF
percentstring=$(df | grep centos-root | tr -s ' ' | cut -d ' ' -f5)
echo "Current Disk Used: $percentstring"

# Get number from percentage
percent=$(echo $percentstring | tr -d '%' )
echo $percent

# Send mail if above 80%
if [ $percent -gt 80 ]; then
	message="Root account is using more than 80% used diskspace"
	echo $message
	echo $message | mail -s "Diskspace Alert - Above 80% used" root@localhost
fi


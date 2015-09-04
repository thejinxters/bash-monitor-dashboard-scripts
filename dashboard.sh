#!/bin/bash

# Get Free Ram
ram=$(free -h | grep Mem | tr -s ' ' | cut -d ' ' -f4)

# Get Load Average
load=$(uptime | cut -d ':' -f5 | tr -d ' ')

# Get i/o Bytes Received
lo=$(cat /proc/net/dev | grep lo | tr -s ' ')
loreceived=$(echo $lo | cut -d ' ' -f2)

# Get i/o Bytes Transmitted
lotransmit=$(echo $lo | cut -d ' ' -f10)

# Ethernet Bytes Received
ethernet=$(cat /proc/net/dev | grep enp0s3 | tr -s ' ')
ethernetreceived=$(echo $ethernet | cut -d ' ' -f2)

# Ethernet Bytes Transmitted
ethernettransmit=$(echo $ethernet | cut -d ' ' -f10)

# Check interconnectivity
interconnectivity="no"
myping=$(ping -c 1 google.com 2> /dev/null)
if [ $? -eq 0 ] ; then
	interconnectivity="yes"
fi

# Get total users
totalusers=$(cat /etc/passwd | cut -d ':' -f1 | sort | uniq | wc -w)

# Get active users
activeusers=$(uptime | tr -s ' ' | cut -d ' ' -f5)

# Get most used shell
topshell=$(cat /etc/passwd | cut -d ':' -f7 | sort | uniq -c | sort -rh | tail -n 1 | tr -s ' ' | cut -d ' ' -f3)


# PRINT DASHBOARD
echo "CPU AND MEMORY RESOURCES -------------------------"
echo "CPU Load Average: $load	Free RAM: $ram"
echo ""

echo "NETWORK CONNECTIONS -------------------------"
echo "lo:	Bytes Received: $loreceived	Bytes Transmittted: $lotransmit"
echo "enp0s3:	Bytes Received: $ethernetreceived	BytesTransmitted: $ethernettransmit"
echo "Internet Connectivity: $interconnectivity"
echo ""

echo "ACCOUNT INFORMATION -------------------------"
echo "Total Users: $totalusers	Number Active: $activeusers"
echo "Most Frequently Used Shell: $topshell"
echo ""

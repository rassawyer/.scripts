#!/bin/bash

## Check if network is connected
ping -c3 8.8.8.8
value=$?
# If network is not connected, send SIGHUP to openVPN
if [ $value != 0 ]
then
	kill -s HUP $(pidof openvpn)
fi

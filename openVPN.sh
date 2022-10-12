#!/bin/bash

if [[ "$*" == "--start" ]]; then
	systemctl restart openvpn-client@UX535.service
elif [[ "$*" == "--stop" ]]; then
	systemctl stop openvpn-client@UX535.service
elif [[ "$*" == "--status" ]]; then
	systemctl status openvpn-client@UX535.service 
else echo "please use --start, --stop, or --status"
fi

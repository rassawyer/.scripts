#!/bin/bash

if [[ "$*" == "--start" ]]; then
	systemctl restart openvpn-client@UX535.service
elif [[ "$*" == "--stop" ]]; then
	systemctl stop openvpn-client@UX535.service
fi

#!/bin/zsh

ethernet_icon="🖧"
wifi_icon="📶"
public_icon="🌍"

output=()

# Grab wifi scan once to avoid multiple slow calls
wifi_scan=$(nmcli -t -f SSID,SIGNAL dev wifi list)

# Get all connected devices
while IFS=: read -r device type state conn; do
    [[ "$state" != "connected" ]] && continue

    ip=$(nmcli -g IP4.ADDRESS dev show "$device" | head -n1 | cut -d/ -f1)
    [[ -z "$ip" ]] && continue

    if [[ "$type" == "wifi" ]]; then
        # Try to match SSID from connection name (usually the same)
        ssid="$conn"
        strength=$(echo "$wifi_scan" | grep "^$ssid:" | cut -d: -f2 | head -n1)
        [[ -z "$strength" ]] && strength="0"

        if [[ "$strength" -ge 70 ]]; then
            color="#00FF00"
        elif [[ "$strength" -ge 40 ]]; then
            color="#FFFFFF"
        else
            color="#FF0000"
        fi

        output+=("{\"text\":\"$wifi_icon $ssid: $ip\",\"tooltip\":\"Signal: ${strength}%\",\"alt\":\"wifi\",\"color\":\"$color\"}")

    elif [[ "$type" == "ethernet" ]]; then
        speed_file="/sys/class/net/$device/speed"
        speed=$(< "$speed_file" 2>/dev/null || echo "0")

        if [[ "$speed" -ge 2500 ]]; then
            color="#00FF00"
        elif [[ "$speed" -ge 1000 ]]; then
            color="#FFFFFF"
        else
            color="#FF0000"
        fi

        output+=("{\"text\":\"$ethernet_icon $device: $ip\",\"tooltip\":\"Speed: ${speed} Mbps\",\"alt\":\"ethernet\",\"color\":\"$color\"}")
    fi
done < <(nmcli -t -f DEVICE,TYPE,STATE,CONNECTION dev)

# Public IP
if command -v curl >/dev/null; then
    public_ip=$(curl -s --max-time 1 https://ipv4.icanhazip.com)
else
    public_ip="N/A"
fi
public_ip="${public_ip//[$'\t\r\n ']}"

output+=("{\"text\":\"$public_icon Public: $public_ip\",\"tooltip\":\"Public IP\",\"alt\":\"public\",\"color\":\"#aaaaaa\"}")

# Output Waybar JSON
echo -n "["
printf "%s," "${output[@]}" | sed 's/,$//'
echo "]"


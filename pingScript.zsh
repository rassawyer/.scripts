#!/bin/zsh

# Function to display usage
usage() {
  echo "Usage: $0 [google|dns]"
  echo "  google  Ping google.com and send notification"
  echo "  dns     Ping 8.8.8.8 and send notification"
  exit 1
}

# Check if a parameter was passed
if [[ -z $1 ]]; then
  usage
fi

# Determine the target based on the parameter
case $1 in
  google)
    TARGET="google.com"
    ;;
  dns)
    TARGET="8.8.8.8"
    ;;
  *)
    usage
    ;;
esac

# Perform the ping and send a notification
RESULT=$(ping -c 5 "$TARGET" | tail -n 2)
notify-send "Ping $TARGET" "$RESULT"


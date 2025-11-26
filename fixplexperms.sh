#!/bin/bash

# Set your main Media root
MEDIA_ROOT="/home/rassawyer/Media/Plex"

# Set the specific subfolders to scan
TARGET_DIRS=(
  "$MEDIA_ROOT/Movies"
  "$MEDIA_ROOT/Music"
  "$MEDIA_ROOT/TV Shows"
  "$MEDIA_ROOT/Downloads/Completed"
)

# Set where to store the last run timestamp
LAST_RUN_FILE="/home/rassawyer/Media/Plex/permissions_last_run"

# Set ownership target (adjust these if needed!)
OWNER="plex"
GROUP="media"

# If no last run file exists, assume very old date
if [ ! -f "$LAST_RUN_FILE" ]; then
  echo "1970-01-01 00:00:00" > "$LAST_RUN_FILE"
fi

# Read the last run time
LAST_RUN=$(cat "$LAST_RUN_FILE")

echo "Last run was at: $LAST_RUN"
echo "Fixing permissions in Plex libraries (Movies, Music, TV Shows)..."

for DIR in "${TARGET_DIRS[@]}"; do
  if [ -d "$DIR" ]; then
    echo "Processing directory: $DIR"

    # Fix ownership (both files and directories)
    find "$DIR" -newermt "$LAST_RUN" -exec chown ${OWNER}:${GROUP} {} \;

    # Fix directory permissions
    find "$DIR" -type d -newermt "$LAST_RUN" -exec chmod 775 {} \;

    # Fix file permissions
    find "$DIR" -type f -newermt "$LAST_RUN" -exec chmod 664 {} \;
  else
    echo "Warning: Directory does not exist: $DIR"
  fi
done

# Update the last run time
date +"%Y-%m-%d %H:%M:%S" > "$LAST_RUN_FILE"

echo "Permissions update complete!"


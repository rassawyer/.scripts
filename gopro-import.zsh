#!/bin/zsh

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RESET='\033[0m'

# Define paths
SOURCE_ROOT="/run/media/rassawyer"
DEST_ROOT="/home/rassawyer/Videos/GoPro"
LOG_FILE="${DEST_ROOT}/import.log"

if [ ! -d $DEST_ROOT ];then
	mkdir $DEST_ROOT
fi

if [ ! -f "$HOME/Videos/GoPro/import.log" ];then
	touch "$HOME/Videos/GoPro/import.log"
fi

# Write timestamped header
echo "\n===== $(date '+%Y-%m-%d %H:%M:%S') - Delete Misc Files Run =====" >> "$LOG_FILE"
printf "\n===== %s - Delete Misc Files Run =====\n" "$timestamp" | tee -a "$LOG_FILE"

# 1. Remove .THM and .LRV files
echo "Removing .THM and .LRV files:" >> "$LOG_FILE"
find "$SOURCE_ROOT" \( -iname "*.THM" -o -iname "*.LRV" \) -type f | while read -r junk; do
	echo "Deleted: $junk" >> "$LOG_FILE"
	rm -v "$junk"
done

# 2. Move .MP4 files into date-based folders
timestamp=$(date '+%Y-%m-%d %H:%M:%S')
printf "\n===== %s - Move MP4 Run =====\n" "$timestamp" | tee -a "$LOG_FILE"
echo "${CYAN}[$timestamp] Starting import of .MP4 files...${RESET}"
find "$SOURCE_ROOT" -type f \( -iname "*.MP4" -o -iname "*.JPG" \) | while read -r file; do
	mod_date=$(stat -c %y "$file" | cut -d' ' -f1)
	target_dir="${DEST_ROOT}/${mod_date}"
	mkdir -p "$target_dir"
	echo "${GREEN}Copying with rsync:${RESET} $file → $target_dir/" | tee -a "$LOG_FILE"
	rsync -a --remove-source-files "$file" "$target_dir/" 2>&1 | tee -a "$LOG_FILE"
done

find "$SOURCE_ROOT" -type f -iname "*.MP4" | while read -r file; do
	mod_date=$(stat -c %y "$file" | cut -d' ' -f1)
	target_dir="${DEST_ROOT}/${mod_date}"
	mkdir -p "$target_dir"
	echo "Moving $file"
	mv "$file" "$target_dir/"
	echo "Moved: $file → $target_dir/" | tee -a "$LOG_FILE"
done

echo -e "${GREEN}Import complete.${RESET}" | tee -a "$LOG_FILE"







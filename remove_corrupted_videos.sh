#!/bin/bash

# === Settings ===
MEDIA_ROOT="/home/rassawyer/Media/Plex"

# Specific subfolders to scan
TARGET_DIRS=(
    "$MEDIA_ROOT/Movies"
    "$MEDIA_ROOT/TV Shows"
)

# Dry-run flag
DRYRUN=false

# Counters
FIXED_COUNT=0
DELETED_COUNT=0
SUBTITLE_DELETED_COUNT=0

# Logging
LOG_DIR="/home/rassawyer/.plex_scripts"
mkdir -p "$LOG_DIR"
ERROR_LOG="$LOG_DIR/ffmpeg_errors_$(date +%Y%m%d_%H%M%S).log"
DELETED_LOG="$LOG_DIR/deleted_files_$(date +%Y%m%d_%H%M%S).log"
FIXED_LOG="$LOG_DIR/fixed_files_$(date +%Y%m%d_%H%M%S).log"

# === Check for dry-run flag ===
if [[ "$1" == "--dry-run" ]]; then
    DRYRUN=true
    echo "🔍 Running in DRY-RUN mode: No files will actually be deleted or modified."
fi

echo "📂 Scanning Plex library at: $MEDIA_ROOT"
echo

# === Main Processing ===
for DIR in "${TARGET_DIRS[@]}"; do
    if [ -d "$DIR" ]; then
        echo "Processing directory: $DIR"
        
        find "$DIR" -type f \( -iname "*.mp4" -o -iname "*.mkv" -o -iname "*.avi" -o -iname "*.mov" \) -print0 | while IFS= read -r -d '' file; do
            # Validate file with ffprobe
            if ! ffprobe -v error -select_streams v:0 -show_entries stream=codec_name -of default=noprint_wrappers=1:nokey=1 "$file" > /dev/null 2>&1; then
                echo "❌ Broken video detected: $file"

                base="${file%.*}"  # Strip extension from video filename
                fixed_file="${file%.*}_fixed.${file##*.}"  # Temp repaired filename

                if [ "$DRYRUN" = true ]; then
                    echo "🛠️ Would attempt to fix: $file → $fixed_file"
                else
                    echo "🛠️ Attempting to fix: $file → $fixed_file"
                    if ffmpeg -v error -i "$file" -c copy "$fixed_file" -y 2>> "$ERROR_LOG"; then
                        echo "✅ Repair successful: Replacing original with fixed file."
                        mv -f "$fixed_file" "$file"
                        echo "$file" >> "$FIXED_LOG"
                        ((FIXED_COUNT++))
                    else
                        echo "🛑 Repair failed: Deleting broken video and subtitles."
                        echo "$file" >> "$DELETED_LOG"
                        rm -v "$file"
                        ((DELETED_COUNT++))

                        # Look for matching subtitle files
                        for sub in "$base".srt "$base".ass "$base".sub "$base".idx "$base".vtt; do
                            if [ -f "$sub" ]; then
                                echo "🗑️ Deleting subtitle: $sub"
                                rm -v "$sub"
                                ((SUBTITLE_DELETED_COUNT++))
                            fi
                        done

                        # Cleanup failed fixed file if it exists
                        [ -f "$fixed_file" ] && rm -v "$fixed_file"
                    fi
                fi
                echo
            fi
        done
    else
        echo "⚠️ Warning: Directory does not exist: $DIR"
    fi
done

echo "✅ Scan complete."
echo

# === Summary ===
echo "📊 Summary:"
echo "- Files successfully repaired: $FIXED_COUNT"
echo "- Files deleted (unrecoverable): $DELETED_COUNT"
echo "- Subtitle files deleted: $SUBTITLE_DELETED_COUNT"

if [ "$DRYRUN" = true ]; then
    echo "🔔 No files were actually modified or deleted (dry-run mode)."
fi

echo
echo "📝 Logs:"
echo "- Errors logged to: $ERROR_LOG"
echo "- Deleted files logged to: $DELETED_LOG"
echo "- Fixed files logged to: $FIXED_LOG"


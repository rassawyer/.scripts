find . -name *.mp4 -exec mv ../ \;

find . -name *.mkv -print -execdir mv '{}' ../ \;

find -type d -empty -delete

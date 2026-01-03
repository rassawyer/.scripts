echo "Updating permissions on directories"
find Media/ -type d -exec sudo chmod 755 {} \; -print

echo "Updating permissions on files"
find Media/ -type f -exec sudo chmod 644 {} \; -print

echo "Changing ownership of files"
find Media/Plex/ -exec sudo chown plex:plex {} \; -print

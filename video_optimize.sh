#! /bin/zsh

#for i in *.mp4; do
#  ffmpeg -i "$i" -c:v dnxhd -profile:v dnxhr_444 -pix_fmt yuv444p10le -c:a pcm_s16le "${i%.*}.mov"
#done
#!/bin/zsh


# Create 'Optimized' folder if it doesn't exist
[[ -d Optimized ]] || mkdir Optimized

setopt +o nomatch

for i in *.mp4 *.mkv; do
  # Skip if no matching files (in case one extension doesn't exist)
  [[ -e "$i" ]] || continue

  # Output filename with .mov extension
  out="Optimized/${i%.*}.mov"

  echo "Processing: $i → $out"

  ffmpeg -i "$i" \
    -c:v dnxhd -profile:v dnxhr_444 -pix_fmt yuv444p10le \
    -c:a pcm_s16le "$out"
done

setopt nomatch

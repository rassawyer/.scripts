#!/bin/zsh

# Enable nullglob-like behavior so we don't error if no matches
setopt NULL_GLOB

# Output directory
OUTPUT_DIR="Resolve_Ready"
mkdir -p "$OUTPUT_DIR"

# Loop through all .mp4 and .MP4 files
for input in *.mp4 *.MP4; do
  # Get base name without extension
  base="${input:t:r}"  # :t = tail (filename), :r = root (remove extension)

  # Output path
  output="$OUTPUT_DIR/${base}_1080p.mov"

  echo "🎬 Converting: $input → $output"

  ffmpeg -i "$input" \
    -vf "scale=1920:1080" \
    -c:v dnxhd -profile:v dnxhr_hq -pix_fmt yuv422p \
    -c:a pcm_s16le \
    "$output"
done

unsetopt NULL_GLOB

echo "✅ All conversions complete. Output in: $OUTPUT_DIR"



#! /bin/zsh

for i in *.mp4; do
  ffmpeg -i "$i" -c:v dnxhd -profile:v dnxhr_444 -pix_fmt yuv444p10le -c:a pcm_s16le "${i%.*}.mov"
done


# Change input and output details

output_path="big" # Output Path (Same will be pushed in main also)
input_url="https://late-mode-9018.fofedo41537672.workers.dev/1396609611/cc234e74066888f04f358b6cb0758d9e8020e08d18a345a7ce1068d9632e9d1c1036079eb7e5a39940909f4d9129c8c2ceadc91e4ed008f315eb69363fcaf028729754291c0ae3ec37c974aae20a6a928aea1f9780bc497a069bdb28b6290bc45cb179515051b45e64d4ab7d85a2bc3869947db80b3ca7e3a9e389f01c7a7a4e::7a29cde365a4e1cda792a5c426a9c5de/Bad.Newz.2024.720p.HD-TS.HINDI.x264.AAC.SkymoviesHD.diy.mkv" # Input direct file url
input_extension="mkv" # Extension of file url



# Change ffmpeg configurations according to yur need (If you don't know, don't touch)

wget --quiet -O video.$input_extension $input_url
mkdir $output_path

ffmpeg -hide_banner -y -i video.$input_extension \
  -vf scale=w=842:h=480:force_original_aspect_ratio=decrease -c:a aac -ar 48000 -c:v h264 -profile:v main -crf 20 -sc_threshold 0 -g 48 -keyint_min 48 -hls_time 1200 -hls_playlist_type vod -b:v 1400k -maxrate 1498k -bufsize 2100k -b:a 128k -hls_segment_filename $output_path/480p_%03d.ts $output_path/480p.m3u8 \
  -vf scale=w=1280:h=720:force_original_aspect_ratio=decrease -c:a aac -ar 48000 -c:v h264 -profile:v main -crf 20 -sc_threshold 0 -g 48 -keyint_min 48 -hls_time 1200 -hls_playlist_type vod -b:v 2800k -maxrate 2996k -bufsize 4200k -b:a 128k -hls_segment_filename $output_path/720p_%03d.ts $output_path/720p.m3u8 

rm video.$input_extension
cd $output_path

echo '#EXTM3U
#EXT-X-VERSION:3
#EXT-X-STREAM-INF:BANDWIDTH=1400000,RESOLUTION=842x480
480p.m3u8
#EXT-X-STREAM-INF:BANDWIDTH=2800000,RESOLUTION=1280x720
720p.m3u8' > master.m3u8

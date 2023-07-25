#!/bin/bash

# Does not require sudo.

blender_save_path="$HOME/Dump"
mkdir -p "$blender_save_path"

blender_mirror="https://mirror.clarkson.edu/blender"
blender_releases=$(wget "$blender_mirror/release/" -q -O -)

latest_blender_release=$(
echo "$blender_releases" \
| grep -B 1 "BlenderBenchmark1.0" \
| grep -v "BlenderBenchmark1.0" \
| sed -r 's/.*href="([^"]+).*/\1/g')

blender_latest=$(wget "$blender_mirror/release/$latest_blender_release" -q -O -)

download_file=$(
echo "$blender_latest" \
| grep "linux-x64" \
| sed -r 's/.*href="([^"]+).*/\1/g')
wget "$blender_mirror/release/$latest_blender_release$download_file" -P "$blender_save_path"

tar zxf "$blender_save_path/$download_file" -C "$HOME/Downloads/Apps/"
rm "$blender_save_path/$download_file"
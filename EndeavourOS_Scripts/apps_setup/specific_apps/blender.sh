#!/bin/bash

# Does not require sudo.

blender_save_path="$1"

blender_mirror="https://mirror.clarkson.edu/blender"
blender_releases=$(wget "$blender_mirror/release/" -q -O -)

latest_blender_release=$(
echo "$blender_releases" \
| grep -B 1 "BlenderBenchmark1.0" \
| grep -v "BlenderBenchmark1.0" \
| sed -r 's/.*href="([^"]+).*/\1/g')

blender_latest=$(wget "$blender_mirror/release/$latest_blender_release" -q -O -)

latest_blender_release_download_url=$(
echo "$blender_latest" \
| grep "linux-x64" \
| sed -r 's/.*href="([^"]+).*/\1/g')

curl -L -0 "$latest_blender_release_download_url" -o "$blender_save_path"
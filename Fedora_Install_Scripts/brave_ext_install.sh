#!/usr/bin/bash

# install extensions via terminal

# fill the array with the needed extensions
# key=["extension_name"] value="extension_ID"

echo "### Installing Browster Extensions ###"

declare -A EXTlist=(
    ["extensity"]="jjmflmamggggndanpgfnpelongoepncg"
    ["unhook-remove-yt-rec"]="khncfooichmfjbepaaaebmommgaepoid"
    ["pocket-tube-subsc"]="kdmnjgijlmjgmimahnillepgcgeemffb"
    ["pocket-tube-playlist"]="bplnofkhjdphoihfkfcddikgmecfehdd"
    ["dark-reader"]="eimadpbcbfnmbkopoojfekhnkhdbieeh"
    ["yt-dislike"]="gebbhagfogifgggkldgodflihgfeippi"
    ["save-to-notion"]="ldmmifpegigmeammaeckplhnjbbpccmm"
    ["bitwarden"]="nngceckbapebfimnlniiiahkandclblb"
    ["kde-plasma-intergration"]="cimiefiiaegbelhefglklhhakcgmhkai"
    ["tabli"]="igeehkedfibbnhbfponhjjplpkeomghi"
    ["raindrop-io"]="ldgfbffkinooeloadekpmfoklnobpien"
    ["tabox"]="bdbliblipiempfdkkkjohnecmeknnpoa"
    ["full-page-screenshot"]="fdpohaocaechififmbbbbbknoalclacl"
    ["octotree-github"]="bkhaagjahfmjljalopjnoealnfndnagc"
    ["tampermonkey"]="dhdgffkkebhmkfjojejmpbldmpobfkfo"
    ["yt-screenshot"]="gjoijpfmdhbjkkgnmahganhoinjjpohk"
)

EXTENSIONS_PATH=/opt/brave.com/brave/extensions
mkdir -p $EXTENSIONS_PATH

for i in "${!EXTlist[@]}"; do
    # echo "Key: $i value: ${EXTlist[$i]}"
    echo '{"external_update_url": "https://clients2.google.com/service/update2/crx"}' > ${EXTENSIONS_PATH}/${EXTlist[$i]}.json

pkill brave

done

#!/bin/bash

# Force user to run this script with root permissions using sudo from non root user.
if ! [ "$(id -u)" = 0 ]; then
   echo "The script need to be run as root." >&2
   exit 1
fi

if [ "$SUDO_USER" ]; then
    real_user=$SUDO_USER
else
    real_user=$(whoami)
    if [ "$real_user" == "root" ]; then
        echo "This script should be run with sudo from non root user."
        exit 1
    fi
fi

if sudo -u "$real_user" ls -la "/etc/sudoers.d/" > /dev/null 2>&1; then
    echo "This script should be run with sudo from a user that does not have root privleges."
    exit 1
fi

# --- (Docs) Regarding permissions for commands and functions. (Docs)
# sudo -u "$real_user" visudo # This will break. ,, Can use bash variables.

# your_root_function () { visudo; } # Issue - Unable to use bash variables.
# export -f your_root_function
# su "$real_user" -c 'your_root_function' # This will break.
# --- (Docs)

declare -A extension_urls=(
    # ["extensity"]="https://chrome.google.com/webstore/detail/extensity/jjmflmamggggndanpgfnpelongoepncg" # installed already, handle later
    # ["unhook-remove-yt-rec"]="https://chrome.google.com/webstore/detail/unhook-remove-youtube-rec/khncfooichmfjbepaaaebmommgaepoid" # installed already, handle later
    ["pocket-tube-subsc"]="https://chrome.google.com/webstore/detail/pockettube-youtube-subscr/kdmnjgijlmjgmimahnillepgcgeemffb"
    ["pocket-tube-playlist"]="https://chrome.google.com/webstore/detail/pockettube-youtube-playli/bplnofkhjdphoihfkfcddikgmecfehdd"
    ["dark-reader"]="https://chrome.google.com/webstore/detail/dark-reader/eimadpbcbfnmbkopoojfekhnkhdbieeh"
    ["save-to-notion"]="https://chrome.google.com/webstore/detail/save-to-notion/ldmmifpegigmeammaeckplhnjbbpccmm"
    # ["yt-dislike"]="https://chrome.google.com/webstore/detail/return-youtube-dislike/gebbhagfogifgggkldgodflihgfeippi" # installed already, handle later
    # ["bitwarden"]="https://chrome.google.com/webstore/detail/bitwarden-free-password-m/nngceckbapebfimnlniiiahkandclblb" # installed already, handle later
#     ["kde-plasma-intergration"]="https://chrome.google.com/webstore/detail/plasma-integration/cimiefiiaegbelhefglklhhakcgmhkai"
#     ["tabli"]="https://chrome.google.com/webstore/detail/tabli/igeehkedfibbnhbfponhjjplpkeomghi"
#     ["raindrop-io"]="https://chrome.google.com/webstore/detail/raindropio/ldgfbffkinooeloadekpmfoklnobpien"
#     ["tabox"]="https://chrome.google.com/webstore/detail/tabox-save-and-share-tab/bdbliblipiempfdkkkjohnecmeknnpoa"
#     ["tampermonkey"]="https://chrome.google.com/webstore/detail/tampermonkey/dhdgffkkebhmkfjojejmpbldmpobfkfo"
#     ["yt-screenshot"]="gjoijpfmdhbjkkgnmahganhoinjjpohk"
#     ["tab-copy"]="https://chrome.google.com/webstore/detail/tabcopy/micdllihgoppmejpecmkilggmaagfdmb"
#     ["open-multiple-urls"]="https://chrome.google.com/webstore/detail/open-multiple-urls/bjifbockcjbcfgbkmleodgdoiglcnenj"
#     ["go-full-page"]="https://chrome.google.com/webstore/detail/gofullpage-full-page-scre/fdpohaocaechififmbbbbbknoalclacl"
#     ["screenshot-youtube"]="https://chrome.google.com/webstore/detail/screenshot-youtube/gjoijpfmdhbjkkgnmahganhoinjjpohk"
)

case $(pacman -Qi) in
    1)
        yay -S xdotool
esac


sudo -u "$real_user" brave </dev/null &>/dev/null &

for ext_url in "${extension_urls[@]}"; do

    sleep 2
    # xdotool key "ctrl+t"
    xdotool key "ctrl+l"
    sleep 1
    xdotool type "$ext_url"
    xdotool key "Return"

    sleep 2

    xdotool key "ctrl+f"
    xdotool type "Add to Brave"
    xdotool key "Return"
    sleep 0.5
    xdotool key "Escape"
    sleep 0.5
    xdotool key "Return"
    sleep 1
    xdotool key "Tab"
    sleep 1
    xdotool key "Return"
    sleep 2
done

echo "Done, hope it worked."
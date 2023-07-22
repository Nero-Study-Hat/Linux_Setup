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

ext_json_file="$HOME/Linux_Setup/data/extenstions.json"
ext_urls_file="$HOME/Linux_Setup/data/extenstions_urls_to_add.txt"

new_extension_urls_to_json () {
  readarray -t extension_urls < "$ext_urls_file"

  bound1="<title>"
  bound2=" - Chrome Web Store</title>"

  if [ ! -f "$ext_json_file" ]; then
    touch "$ext_json_file"
  fi

  if [ "$(tail -n 1 "$ext_json_file")" = "]" ]; then
    sed -i "s/]//" "$ext_json_file"
    clean_ext_file=$(sed 's/^ *//; s/ *$//; /^$/d; /^\s*$/d' "$ext_json_file")
    echo "$clean_ext_file" > "$ext_json_file"
  fi

  first_line=$(head -n 1 "$ext_json_file")
  if [ ! "$first_line" = "[" ]; then
    sed -i "1i [" "$ext_json_file"
  fi

  for ext_url in "${extension_urls[@]}"; do
    ext_name=$("$(curl -L "$ext_url")" | grep -oP "(?<=$bound1).*(?=$bound2)")
    ext_id="${ext_url##*/}"

    ext_json_string="$(
      jq --null-input \
        --arg name "${ext_name}" \
        --arg url "${ext_url}" \
        --arg id "${ext_id}" \
        '$ARGS.named'
    ),"

    sleep 0.5
    echo "$ext_json_string" >> "$ext_json_file"
  done

  clean_ext_file=$(tac "$ext_json_file" | sed '2 s/.*/}/' | tac)
  "$clean_ext_file" > "$ext_json_file"
  last_line=$(tail -n 1 "$ext_json_file")
  sleep 0.5
  if [ ! "$last_line" = "]" ]; then
    echo ']' >> "$ext_json_file"
  fi

  echo "" > "$ext_urls_file"
}

# if file is not empty
if [ -s "$ext_urls_file" ]; then
  export -f 'new_extension_urls_to_json'
  su "$real_user" -c 'new_extension_urls_to_json'
fi

if [ ! -s "$ext_json_file" ]; then
  echo "Extenstions JSON file is empty, please fill it."
  exit 1
fi

# --- #

# case $(pacman -Qi) in
#     1)
#         yay -S xdotool
# esac

# sudo -u "$real_user" brave </dev/null &>/dev/null &


# for ext_url in "${extension_urls[@]}"; do

#     sleep 2
#     # xdotool key "ctrl+t"
#     xdotool key "ctrl+l"
#     sleep 1
#     xdotool type "$ext_url"
#     xdotool key "Return"

#     sleep 2

#     xdotool key "ctrl+f"
#     xdotool type "Add to Brave"
#     xdotool key "Return"
#     sleep 0.5
#     xdotool key "Escape"
#     sleep 0.5
#     xdotool key "Return"
#     sleep 1
#     xdotool key "Tab"
#     sleep 1
#     xdotool key "Return"
#     sleep 2
# done

# echo "Done, hope it worked."

# sudo pacman -S jq
# # qdbus org.kde.klipper /klipper setClipboardContents "empty"

# ClipboardReplace () {
#     xdotool key "space"
#     xdotool key "ctrl+5"
#     xdotool key "ctrl+a"
#     xdotool key "BackSpace"
#     xdotool type "boo"
#     sleep 0.2
#     xdotool key "Return"
# }

# ClipboardReplace

# xdotool key "ctrl+a"
# xdotool key "BackSpace"
# xdotool key "Return"

# clipboard_contents=$(qdbus org.kde.klipper /klipper getClipboardContents)
# clipboard_contents=$(qdbus org.kde.klipper /klipper getClipboardHistoryItem 0)

# sleep 0.5

# echo "$clipboard_contents"
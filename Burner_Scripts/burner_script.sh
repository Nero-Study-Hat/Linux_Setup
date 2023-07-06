#!/bin/bash

# Force user to run this script with root permissions using sudo from non root user.
# if ! [ "$(id -u)" = 0 ]; then
#    echo "The script need to be run as root." >&2
#    exit 1
# fi

# if [ "$SUDO_USER" ]; then
#     real_user=$SUDO_USER
# else
#     real_user=$(whoami)
#     if [ "$real_user" == "root" ]; then
#         echo "This script should be run with sudo from non root user."
#         exit 1
#     fi
# fi
# ---

# --- (Docs) Regarding permissions for commands and functions. (Docs)
# sudo -u "$real_user" visudo # This will break.

# your_root_function () { visudo; }
# export -f your_root_function
# su "$real_user" -c 'your_root_function' # This will break.
# --- (Docs)

declare -a apps=(
    "code" # text editor
    "cool-retro-term" # terminal emulator
    "github-desktop" # github client
    "direnv" # bash scripting utility
)

read -r -p "Do you want to install all development apps, none, or make a custom selection of apps. (1/2/3)" apps_choice
case "$apps_choice" in

  1)
    for app in "${apps[@]}"; do
        yay -S "$app"
    done
    ;;

  2)
    :
    ;;

  3)
    for i in "${!apps[@]}";
    do 
        printf "%s\t%s\n" "$i" "${apps[$i]}"
    done

    echo
    read -r -p 'Input the numbers for the apps you want space separated: ' -a chosen_apps_indexes

    declare -a chosen_apps
    for app_index in "${chosen_apps_indexes[@]}"
    do
        chosen_apps+=("${apps[$app_index]}")
    done

    for app in "${chosen_apps[@]}"
    do
        yay -S "$app"
    done
    ;;

  *)
    STATEMENTS
    ;;
esac
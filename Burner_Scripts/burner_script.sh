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

# if sudo -u "$real_user" ls -la "/etc/sudoers.d/" > /dev/null 2>&1; then
#     echo "This script should be run with sudo from a user that does not have root privleges."
#     exit 1
# fi

# --- (Docs) Regarding permissions for commands and functions. (Docs)
# sudo -u "$real_user" visudo # This will break.

# your_root_function () { visudo; }
# export -f your_root_function
# su "$real_user" -c 'your_root_function' # This will break.
# --- (Docs)


declare -a test_dirs=(
    "dir_1"
    "dir_2"
    "dir_3"
    "dir_4"
)

for dir in "${test_dirs[@]}"; do
    data_dir_path="/mnt/data"
    abs_dir_path="$HOME/Linux_Setup/Burner_Scripts/$dir"
    
    if [ -d "$abs_dir_path" ] && [ "$(find /home/nero/Music -maxdepth 0 -empty  > /dev/null 2>&1)" ] && [ ! -L "$abs_dir_path" ]; then
        rmdir "$abs_dir_path"
    fi

    if [ "$(find "$abs_dir_path" -maxdepth 0 -empty  > /dev/null 2>&1)" ] && [ ! -L "$abs_dir_path" ]; then # Handle this.
        echo "$abs_dir_path is not empty, skipping this directory."
        continue
    fi

    if [ -L "$abs_dir_path" ]; then
        link_source_dir_path=$(readlink -f "$abs_dir_path")
        if [ ! "$link_source_dir_path" = "$data_dir_path" ]; then
            if [ "$(find "$link_source_dir_path" -maxdepth 0 -empty  > /dev/null 2>&1)" ];
                then unlink "$dir";
                else echo "$dir points to a not empty directory, skipping this linked directory.";
            fi
        fi
    fi
done
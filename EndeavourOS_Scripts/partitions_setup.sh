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

data_dir_path="/mnt/data"

mkdir -p "$data_dir_path"
chown "$USER":"$USER" "$data_dir_path"

fstab_file="/etc/fstab"
storage_partition_line="UUID=9e1125ec-ecc0-4fb1-9754-0dead41102dd     $data_dir_path    ext4     relatime 0 2"

sed -i "13i $storage_partition_line" "$fstab_file"

mount -a
systemctl daemon-reload

declare -a home_directories=(
    "Downloads"
    "Documents"
    "Music"
    "Pictures"
    "Videos"
    "Workspace"
)

home_directory_cleanup () {
    for dir in "${home_directories[@]}"; do
        abs_dir_path="$HOME/Linux_Setup/Burner_Scripts/$dir"
        
        if [ -d "$abs_dir_path" ] && [ ! -L "$abs_dir_path" ]; then
            rmdir "$abs_dir_path"
        fi
        if [ -L "$abs_dir_path" ]; then
            link_source_dir_path=$(readlink -f "$abs_dir_path")
            echo "Directory $dir link exists pointing to $(readlink -f "$abs_dir_path")."
            if [ ! "$link_source_dir_path" = "$data_dir_path" ]; then
                unlink "$dir"
            fi
        fi
    done
}

su "$real_user" -c 'home_directory_cleanup' # Regular user privleges.
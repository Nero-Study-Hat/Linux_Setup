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

declare -a home_directories_blacklist=()

home="$(getent passwd "$SUDO_USER" | cut -d: -f6)"

for dir in "${home_directories[@]}"; do
    data_dir_path="/mnt/data"
    abs_dir_path="$home/$dir"
    
    if [ -d "$abs_dir_path" ] && [ ! "$(ls -A "$abs_dir_path")" ] && [ ! -L "$abs_dir_path" ]; then
        sudo -u "$real_user" rmdir "$abs_dir_path"
    fi

    if [ -d "$abs_dir_path" ] && [ ! -L "$abs_dir_path" ] && [ "$(ls -A "$abs_dir_path")" ]; then
        echo "$abs_dir_path is not empty, skipping this directory."
        home_directories_blacklist+=("$dir")
        continue
    fi

    if [ -L "$abs_dir_path" ]; then
        link_source_dir_path=$(readlink -f "$abs_dir_path")
        if [ "$link_source_dir_path" = "$data_dir_path/$dir" ];
            then
                home_directories_blacklist+=("$dir")
                continue;
            else
                if [ "$(ls -A "$link_source_dir_path")" ];
                    then 
                        echo "$dir points to a not empty directory, skipping this linked directory."
                        home_directories_blacklist+=("$dir");
                    else 
                        sudo -u "$real_user" unlink "$home/$dir";
                fi;        
        fi
    fi
done

for dir in "${home_directories[@]}"; do
    if [[ ! ${home_directories_blacklist[*]} =~ ${dir} ]]; then
        sudo -u "$real_user" ln -s "$data_dir_path/$dir" "$home/$dir"
    fi
done
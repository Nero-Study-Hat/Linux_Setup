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

echo "HELP ME" #DEBUG

declare -a home_directories_blacklist=()

# home_directory_cleanup () {
#     for dir in "${home_directories[@]}"; do
#         data_dir_path="/mnt/data"
#         abs_dir_path="$HOME/Linux_Setup/Burner_Scripts/$dir"
        
#         if [ -d "$abs_dir_path" ] && [ "$(find "$abs_dir_path" -maxdepth 0 -empty  > /dev/null 2>&1)" ] && [ ! -L "$abs_dir_path" ]; then
#             rmdir "$abs_dir_path"
#         fi

#         if [ "$(find "$abs_dir_path" -maxdepth 0 -empty  > /dev/null 2>&1)" ] && [ ! -L "$abs_dir_path" ]; then # Handle this.
#             echo "$abs_dir_path is not empty, skipping this directory."
#             home_directories_blacklist+=("$dir")
#             continue
#         fi

#         if [ -L "$abs_dir_path" ]; then
#             link_source_dir_path=$(readlink -f "$abs_dir_path")
#             if [ "$link_source_dir_path" = "$data_dir_path/$dir" ];
#                 then
#                     home_directories_blacklist+=("$dir")
#                     continue;
#                 else
#                     if [ "$(find "$link_source_dir_path" -maxdepth 0 -empty  > /dev/null 2>&1)" ];
#                         then 
#                             unlink "$dir";
#                         else 
#                             echo "$dir points to a not empty directory, skipping this linked directory."
#                             home_directories_blacklist+=("$dir");
#                     fi;        
#             fi
#         fi
#     done
# }

# symlinking () {
#     for dir in "${home_directories[@]}"; do
#         if [[ ! ${home_directories_blacklist[*]} =~ ${dir} ]]; then
#             ln -s "$data_dir_path/$dir" "$HOME/$dir"
#         fi
#     done
# }

# # Regular user privleges.
# export -f home_directory_cleanup
# export -f symlinking

# su "$real_user" -c 'home_directory_cleanup'
# su "$real_user" -c 'symlinking'

for dir in "${home_directories[@]}"; do
    data_dir_path="/mnt/data"
    abs_dir_path="$HOME/$dir"

    echo "abs dir path is -> $abs_dir_path" #DEBUG
    
    if [ -d "$abs_dir_path" ] && [ "$(find "$abs_dir_path" -maxdepth 0 -empty  > /dev/null 2>&1)" ] && [ ! -L "$abs_dir_path" ]; then
        echo "removing $dir dir" #DEBUG

        rmdir "$abs_dir_path"
    fi

    if [ "$(find "$abs_dir_path" -maxdepth 0 -empty  > /dev/null 2>&1)" ] && [ ! -L "$abs_dir_path" ]; then # Handle this.
        echo "$abs_dir_path is not empty, skipping this directory."
        home_directories_blacklist+=("$dir")
        continue
    fi

    if [ -L "$abs_dir_path" ]; then
        echo "$abs_dir_path is a link" #DEBUG

        link_source_dir_path=$(readlink -f "$abs_dir_path")
        if [ "$link_source_dir_path" = "$data_dir_path/$dir" ];
            then
                home_directories_blacklist+=("$dir")
                continue;
            else
                if [ "$(find "$link_source_dir_path" -maxdepth 0 -empty  > /dev/null 2>&1)" ];
                    then 
                        unlink "$dir";
                    else 
                        echo "$dir points to a not empty directory, skipping this linked directory."
                        home_directories_blacklist+=("$dir");
                fi;        
        fi
    fi
done

for dir in "${home_directories[@]}"; do
    echo "symlink dir is $dir" #DEBUG
    echo "symlinking" #DEBUG

    if [[ ! ${home_directories_blacklist[*]} =~ ${dir} ]]; then
        ln -s "$data_dir_path/$dir" "$HOME/$dir"
    fi
done

echo "\ \ / / | '__| __| | || |_| '_ \\"
echo "\ \ / / | '__| __| | || |_| '_ "'\'
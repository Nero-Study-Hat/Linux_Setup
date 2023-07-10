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
# ---

dotnet_save_path="$1"
#TODO: Make this accessed from a config file or something.
dotnet_download_link='https://download.visualstudio.microsoft.com/download/pr/87a55ae3-917d-449e-a4e8-776f82976e91/03380e598c326c2f9465d262c6a88c45/dotnet-sdk-7.0.305-linux-x64.tar.gz'


curl -L -0 "$dotnet_download_link" -o "$dotnet_save_path"
sudo -u "$real_user" mkdir -p "$HOME/.dotnet" && tar zxf dotnet-sdk-7.0.305-linux-x64.tar.gz -C "$HOME/.dotnet"

dotnet_exports_filepath="/etc/profile.d/dotnet.sh"

touch "$dotnet_exports_filepath"
echo "#!/bin/bash" | tee -a "$dotnet_exports_filepath" 1>/dev/null
printf "\n" | tee -a "$dotnet_exports_filepath" 1>/dev/null
echo "export DOTNET_ROOT=\$HOME/.dotnet" | tee -a "$dotnet_exports_filepath" 1>/dev/null
echo "export PATH=\$PATH:\$HOME/.dotnet" | tee -a "$dotnet_exports_filepath" 1>/dev/null
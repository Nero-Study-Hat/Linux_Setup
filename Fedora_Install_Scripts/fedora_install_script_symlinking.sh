#!/bin/bash
# Partition seperating files sym linking.
sudo mkdir /mnt/data
sudo chown $USER:$USER /mnt/data
sudo blkid
# Prompts
echo Check for storage partition UUID and copy it. Start with 99.
echo Use the following the fstab. -> UUID=XXXX     /mnt/data    ext4     relatime 0 2
# Text Editor & Update
#sudo -H gedit /etc/fstab
kate /etc/fstab
sudo mount -a
systemctl daemon-reload
# Home Folders Deletion
rmdir Music Videos Pictures  Workspace Documents Downloads
# Symlinking
ln -s /mnt/data/Music $HOME/Music
ln -s /mnt/data/Videos $HOME/Videos
ln -s /mnt/data/Pictures $HOME/Pictures
ln -s /mnt/data/Workspace $HOME/Workspace
ln -s /mnt/data/Documents $HOME/Documents
ln -s /mnt/data/Downloads $HOME/Downloads
echo Done

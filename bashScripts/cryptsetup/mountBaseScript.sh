#!/bin/bash

recovery_password="$1"
device="$2"
mount_point="/media/mount/$device"
mount_device="/dev/$device"
sudo mkdir -p "$mount_point"
if [ $? -ne 0 ]; then
    echo "$mount_device"
    exit 1  # Выход с ненулевым кодом завершения (1 в данном случае)
fi
echo "$recovery_password" | sudo cryptsetup open -M bitlk $mount_device $device
if [ $? -ne 0 ]; then
    echo "$mount_device"
    exit 1  # Выход с ненулевым кодом завершения (1 в данном случае)
fi
sudo mount /dev/mapper/$device $mount_point
if [ $? -ne 0 ]; then
    echo "$mount_device"
    exit 1  # Выход с ненулевым кодом завершения (1 в данном случае)
fi
echo "Раздел $mount_device разблокирован и смонтирован в $mount_point"
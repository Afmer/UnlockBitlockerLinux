#!/bin/bash

device="$1"
sudo umount /media/mount/$device
if [ $? -ne 0 ]; then
    echo "$device"
    exit 1  # Выход с ненулевым кодом завершения (1 в данном случае)
fi
sudo cryptsetup close $device
if [ $? -ne 0 ]; then
    echo "$device"
    exit 1  # Выход с ненулевым кодом завершения (1 в данном случае)
fi
echo "Диск $device размонтирован"
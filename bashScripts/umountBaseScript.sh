#!/bin/bash

device="$1"

sudo umount /media/mount/$device
if [ $? -ne 0 ]; then
    echo "$device"
    exit 1  # Выход с ненулевым кодом завершения (1 в данном случае)
fi
sudo umount /media/bitlocker/$device
if [ $? -ne 0 ]; then
    echo "$device"
    exit 1  # Выход с ненулевым кодом завершения (1 в данном случае)
fi
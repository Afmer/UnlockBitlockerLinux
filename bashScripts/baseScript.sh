#!/bin/bash
recovery_password="$1"
device="$2"
bitlocker_mount="/media/bitlocker/$device"
mount_point="/media/mount/$device"
mount_device="/dev/$device"

# Создаем директорию для монтирования, если она не существует
sudo mkdir -p "$bitlocker_mount"
if [ $? -ne 0 ]; then
    echo "$mount_device"
    exit 1  # Выход с ненулевым кодом завершения (1 в данном случае)
fi
sudo mkdir -p "$mount_point"
if [ $? -ne 0 ]; then
    echo "$mount_device"
    exit 1  # Выход с ненулевым кодом завершения (1 в данном случае)
fi
# Разблокировка раздела с BitLocker с использованием ключа восстановления
sudo dislocker -v -V $mount_device --recovery-password=$recovery_password $bitlocker_mount
if [ $? -ne 0 ]; then
    echo "$mount_device"
    exit 1  # Выход с ненулевым кодом завершения (1 в данном случае)
fi
# Монтируем раздел
sudo mount -o loop "$bitlocker_mount/dislocker-file" "$mount_point"
if [ $? -ne 0 ]; then
    echo "$mount_device"
    exit 1  # Выход с ненулевым кодом завершения (1 в данном случае)
fi
echo "Раздел $mount_device разблокирован и смонтирован в $mount_point"
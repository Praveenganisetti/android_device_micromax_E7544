#!/system/bin/sh

setenforce 0

#Unmount Partitions
umount /system_root 2>&1 | grep message
umount /product 2>&1 | grep message
umount /vendor 2>&1 | grep message
umount /system_ext 2>&1 | grep message

sleep 1
mount -w /product > /dev/null
mount -w /vendor > /dev/null
mount -w /system_root > /dev/null
mount -w /system_ext > /dev/null

umount /product > /dev/null
umount /vendor > /dev/null
umount /system_root > /dev/null
umount /system_ext > /dev/null

mount -o rw /system_root | grep message
mount -o rw /product | grep message
mount -o rw /vendor | grep message
mount -o rw /system_ext | grep message

#Set Mounted Partitions As R/W
/bin/blockdev --setrw /dev/block/mapper/system_b | grep message
/bin/blockdev --setrw /dev/block/mapper/product_b | grep message
/bin/blockdev --setrw /dev/block/mapper/vendor_b | grep message
/bin/blockdev --setrw /dev/block/mapper/system_ext_b | grep message
/bin/blockdev --setrw /dev/block/platform/bootdevice/by-name/metadata


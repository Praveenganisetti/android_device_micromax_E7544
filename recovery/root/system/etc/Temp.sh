#!/system/bin/sh

# clear the first 32 bytes of the misc partition to prevent unnecessary bootloops to recovery
# this is only required when building with 10.0+ manifests
clear_init_fatal_reboot_target() {
    local bytes=512;
    usleep 4096;
    echo "Executing $0" >> /tmp/recovery.log

    # Find the misc partition in the specified directory
    local MISC_PATH=$(find /dev/block/platform/* -type f -o -type l -name 'misc' 2>/dev/null | head -n 1)
    
    # Check if MISC_PATH is found
    if [ -z "$MISC_PATH" ]; then
        echo "Misc partition not found" >> /tmp/recovery.log
        exit 1
    fi
    
    # Clear the first 32 bytes
    dd if=/dev/zero of=$MISC_PATH bs=$bytes count=1;
    usleep 4096;
}

clear_init_fatal_reboot_target;
exit 0;

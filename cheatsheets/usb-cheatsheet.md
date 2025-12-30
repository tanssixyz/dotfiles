# USB Drive Management Cheatsheet - Arch Linux

## Identify Your USB Drive
```bash
lsblk                    # List all block devices
sudo fdisk -l            # Detailed list of drives
```
Your USB will typically be `/dev/sdb` or `/dev/sdc` (partition: `/dev/sdb1`)

## Formatting

### Format as FAT32 (Windows/Mac compatible)
```bash
sudo mkfs.vfat -F 32 /dev/sdb1
```

### Format as ext4 (Linux optimized)
```bash
sudo mkfs.ext4 /dev/sdb1
```

### Format as exFAT (large files, cross-platform)
```bash
sudo pacman -S exfatprogs        # Install first
sudo mkfs.exfat /dev/sdb1
```

## Mounting

### Manual mount
```bash
sudo mkdir -p /mnt/usb           # Create mount point
sudo mount /dev/sdb1 /mnt/usb    # Mount the drive
```

### Mount with write permissions (FAT32)
```bash
sudo mount -o rw,umask=0000 /dev/sdb1 /mnt/usb
```

### Check where USB is mounted
```bash
lsblk                            # Shows mount points
mount | grep /dev/sdb1           # Specific device info
```

## Unmounting
```bash
sudo umount /dev/sdb1            # Unmount by device
sudo umount /mnt/usb             # Unmount by mount point
```

### Force unmount (if busy)
```bash
sudo umount -l /dev/sdb1         # Lazy unmount
sudo fuser -km /mnt/usb          # Kill processes using it
```

## Renaming (Labels)

### FAT32 label
```bash
sudo fatlabel /dev/sdb1 "NEW_NAME"
```

### ext4 label
```bash
sudo e2label /dev/sdb1 "NEW_NAME"
```

### exFAT label
```bash
sudo exfatlabel /dev/sdb1 "NEW_NAME"
```

## Checking/Repairing Filesystem

### FAT32
```bash
sudo umount /dev/sdb1            # Unmount first
sudo fsck.vfat /dev/sdb1         # Check and repair
```

### ext4
```bash
sudo umount /dev/sdb1
sudo fsck.ext4 /dev/sdb1
```

## Auto-mounting with Thunar
```bash
sudo pacman -S gvfs gvfs-mtp udisks2
```
After installing, restart Thunar. USBs will auto-mount to `/run/media/yourusername/`

## Partitioning (if needed)

### Interactive partitioning tool
```bash
sudo cfdisk /dev/sdb             # User-friendly TUI
```

### Create new partition table and partition
```bash
sudo fdisk /dev/sdb
# Commands in fdisk:
# g = create GPT partition table
# n = create new partition
# w = write changes and exit
```

## Useful Commands

### Show USB info
```bash
lsusb                            # List USB devices
sudo fdisk -l /dev/sdb           # Detailed device info
```

### Eject safely
```bash
sudo eject /dev/sdb              # Safe removal
```

### Wipe drive completely
```bash
sudo dd if=/dev/zero of=/dev/sdb bs=4M status=progress
# WARNING: This erases EVERYTHING on the drive!
```

## Common Issues

**"Device is busy" when unmounting:**
```bash
lsof | grep /mnt/usb             # Find what's using it
cd ~                             # Leave the directory
sudo umount /dev/sdb1
```

**Read-only filesystem:**
- Check filesystem with `fsck`
- Remount with `-o rw` option
- Check if write-protect switch is enabled on USB

**Permission denied:**
```bash
sudo chown -R $USER:$USER /mnt/usb
sudo chmod -R 755 /mnt/usb
```

#!/bin/bash
echo 'cgroup  /sys/fs/cgroup  cgroup  defaults                        0       0' >> /etc/fstab
sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/GRUB_CMDLINE_LINUX_DEFAULT="quiet cgroup_enable=memory swapaccount=1"/' /etc/default/grub
update-grub
mount /sys/fs/cgroup
reboot
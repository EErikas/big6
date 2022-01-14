#!/bin/bash
# This is used on the Ubuntu machine that I developed this vagrantfile
# apparently for some reason the Debian image refuses to find /mnt unless the 'vagrant-vbguest' is freshly installed...
# Therefore this script destroys the VM, removed plugin and starts the VM again
vagrant destroy -f
vagrant plugin uninstall vagrant-vbguest
vagrant up
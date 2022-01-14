unless Vagrant.has_plugin?("vagrant-vbguest")
  system('vagrant plugin install vagrant-vbguest')
end

Vagrant.configure("2") do |config|
  config.vm.define "box" do |box|

    # Set VM CPUs and RAM
    box.vm.provider "virtualbox" do |vb|
      vb.name = "BIG 6"
      vb.cpus = 4
      vb.memory = 1024
    end

    # Chose Debian 9 as base for the VM
    box.vm.box = "debian/stretch64"
    box.vm.hostname = "gr6"

    # Provision required files
    box.vm.provision :file,
      source: './provisions',
      destination: '/home/vagrant'
    
    # Setting up VM for LXC:
    box.vm.provision :shell,
      inline: <<-SCRIPT
      echo "Installing required pacakges"
      apt install unzip pkg-config autotools-dev automake gcc libcap-dev python3-dev liblua5.1-0-dev libselinux1-dev libapparmor-dev libapparmor-dev libapparmor-dev build-essential dnsmasq-base debootstrap rsync htop -y
      
      echo "Downloading lxc 1.15.1"
      wget https://codeload.github.com/lxc/lxc/zip/refs/tags/lxc-1.1.5 -O lxc.zip && unzip lxc.zip
      
      echo "Installing lxc"
      cd lxc-lxc-1.1.5/ && ./autogen.sh && ./configure --prefix=/ --enable-python --enable-rpath && make CFLAGS=-Wno-error && make install

      echo "Setting up lxc-net"
      mv /home/vagrant/default.conf /etc/lxc/default.conf
      mv /home/vagrant/lxc-net /etc/default/lxc-net
      service lxc-net restart

      echo "Setting up cgroups"
      echo 'cgroup  /sys/fs/cgroup  cgroup  defaults                        0       0' >> /etc/fstab
      sed -i 's/GRUB_CMDLINE_LINUX_DEFAULT="quiet"/GRUB_CMDLINE_LINUX_DEFAULT="quiet cgroup_enable=memory swapaccount=1"/' /etc/default/grub
      update-grub

      SCRIPT
        
    # Set up containers
    "ABC".split('').each do |i|
      ## Create container and make it autostart when machine boots
      box.vm.provision :shell,
        inline: <<-SCRIPT
        echo "Setting up container #{i}"
        lxc-create -n Container#{i} -t debian -- -r jessie && echo 'lxc.start.auto = 1' >> /var/lib/lxc/Container#{i}/config
        
        echo "Setting up network"
        mv /home/vagrant/Container#{i}-netconfig /var/lib/lxc/Container#{i}/rootfs/etc/network/interfaces
        
        echo "Starting container #{i}"
        lxc-start -n Container#{i}

        echo "Setting up Container#{i}"
        cp -r /home/vagrant/demo-utils /var/lib/lxc/Container#{i}/rootfs/root/
        lxc-attach -n Container#{i} -- /bin/bash -c 'apt install iputils-ping -y && chmod +x /root/demo-utils/*.sh'

        SCRIPT
    end

    box.vm.provision :shell,
      inline: <<-SCRIPT
      echo "Preparing container escape demonstration on ContainerA..."
      mv /home/vagrant/lxc-escape/* /var/lib/lxc/ContainerA/rootfs/root/
      lxc-attach -n ContainerA -- /bin/bash -c 'apt install gcc -y && chmod +x /root/exploit.sh'

      echo "Preparing container with host root share on ContainerB..."
      echo "lxc.mount.entry = / secrets none rw,bind,create=dir 0.0" >> /var/lib/lxc/ContainerB/config

      echo "Cleaning up..."
      rm -rf /home/vagrant/lxc*


      python3 /home/vagrant/show.py
      SCRIPT

  end
end

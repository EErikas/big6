# Breaking Isolation by Group 6 (BIG6)

This is out implementatation for the "Breaking Isolation" lab work for ***ELEC-E7330 - Laboratory Course in Internet Technologies*** course.
The repository hosts a Vagrantfile that is used to set up an environment for our experiments that we have provided in our report.

## Requirements

The following software is required:
* [Oracle VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [VirtualBox Extension Pack](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](https://www.vagrantup.com/docs/installation)

You will also need to setup VirtualBox as the default provider for Vagrant, more on that: https://www.vagrantup.com/docs/providers

## Usage

### Launching environment

To launch the environment, navigate in CLI interface to the location of the `Vagrantfile` and use the following command:

```bash
vagrant up
```

After command finnishes the execution, you are all set to use the VM

**NOTE:** Do not remove any of the files that come in this repository, as they are crucial to make the environment setup

### Connecting to the VM

You can open the VM by  using VirtualBox GUI, where you can find by name `BIG 6` , or bnavigating to the location of `Vagrantfile` in your CLI interface and entering the following command:

```bash
vagrant ssh
```

You will be logged in as user `vagrant` via ssh interface.

### Destroying the environment

Easiest way to destroy of the environment is by using command

```bash
vagrant destroy -f
```

You can also shutdown and remove the `BIG 6` VM and the base VM, which is going to be named in such fashion: `stretch_XXXX_XXXX` by using VirtualBox GUI interface.

## Known Issues

On my machine, which is running `Ubuntu 20.04 LTS` based distro, I was having an issue where the environment might have issues to be relaunched if the `vagrant-vbguest` package was installed previously, to fix that, I used the following commands:

```bash
vagrant destroy -f
vagrant plugin uninstall vagrant-vbguest
vagrant up
```

You can copy these commands or use the `weird-restart.sh` script if you are running a unix based OS.

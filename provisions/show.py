import subprocess


print("Container IPs:")
command = "lxc-attach -n Container{} -- /bin/bash -c 'hostname -I'"
for foo in 'ABC':
    output = subprocess.getoutput(command.format(foo))
    print('Container{0}: {1}'.format(foo, output))

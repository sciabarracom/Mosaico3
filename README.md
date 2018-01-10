# Mosaico 3

Scripts to install a kubernetes cluster in Vagrant

You need a `bash` enviroment with SSH, either a Linux Distro, a Mac OSX or Windows Bash

You need also VirtualBox, Vagrant and Ansible installed in your environment.

# Create VMs with vagrant

- `cd provision/vagrant`
- `vagrant up`
- `vagrant ssh-config >>~/.ssh/config`

# Provision with ansible
- `cd ../ansible`
- `ansible-playbook site.yml`

That is. Once done, `vagrant ssh master` and start playing with `Kubernetes`








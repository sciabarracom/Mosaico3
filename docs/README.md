# Mosaico 3

Scripts to install a kubernetes cluster in Vagrant

You need a `bash` enviroment with SSH, either a Linux Distro, a Mac OSX or Windows 10 Bash (see below for Windows)

You need also VirtualBox, Vagrant and Ansible installed in your environment. 

![Kubernetes On VirtualBox in Windows](kubernetes-the-hard-way.png)

# Setup on Linux/OSX

The kit is for Unix, so works out of the box in Linux and OSX, as follows.

## Create VMs in Virtualbox with vagrant

- `cd servers/vbox`
- `vagrant up`
- `vagrant ssh-config >>~/.ssh/config`

## Edit your `hosts` file

Run `sudo vi /etc/hosts` and add the following line:

`127.0.0.1 master node1 node2 node3`

## Provision Kubernetes with ansible

- `pip install ansible`
- `cd ../../kubernetes`
- `ansible-playbook site.yml`

That is. Once done, `vagrant ssh master` and start playing with `Kubernetes`

# Setup on windows

The kit work also on Windows 10. However since Windows is not a native Unix, the procedure is slightly more complex and involves the use of two shells, the native PowerShell and Windows Bash.

The main problem is on Windows, `ansible` is not available as a Windows application. You need to install [Windows 10 Bash](https://www.windowscentral.com/how-install-bash-shell-command-line-windows-10) to use Ansible.  On the other side, both VirtualBox and Vagrant are native Windows applications and does not work with Windows Bash.

So the procedure on Windows 10 is the following.

## Create VMs with Vagrant in Windows

First of course download Mosaico. Then install [VirtualBox](https://www.virtualbox.org/wiki/Downloads) and [Vagrant](https://www.vagrantup.com/downloads.html) for Windows, and open a Windows shell (CMD or PowerShell).

- `cd servers\vbox`
- `vagrant up`
- `vagrant ssh-config >config`

Note we started the VM with Vagrant for Windows and we saved the configuration in a local file.

## Add an entry in Windows hosts file

You need to launch notepad as an administrator. Search notepad then right-click and run it as an Administrator. Then open the file `c:\Windows\System32\Drivers\etc\hosts` and add the following line:

`127.0.0.1 master node1 node2 node3`

Remember to save it.

## Provision Kubernetes with Windows bash

Now, ensure you have Windows Bash. Go in the Windows Store and install Ubuntu.
Finally, open Windows bash,  and do the following steps.

First install `python`, `pip` and `ansible`:

- `sudo apt-get update`
- `sudo apt-get install python-pip`
- `sudo pip install ansible`

Second, create a proper configuration file for `ssh` (note we have to replace  `C:` with `/mnt/c`)

- `mkdir $HOME/.ssh`
- `cd Mosaico3/servers/vbox`
- `sed -e 's!C:!/mnt/c!g' <config >>$HOME/.ssh/config`

Finally you can provision with `ansible` Kubernetes:

- `cd ../../kubernetes`
- `ansible-playbook sites.yml`

# Access the cluster with kubectl

Vagrant exposes port 6443 and the certificate can be used with the master hostname (by default `master`). 

If you have installed [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) you can retrieve the configuration with:

```
ssh master sudo cat /etc/kubernetes/admin.conf  | sed -e 's/10.0.0.10/master/' >~/.kube/config
```

After this command check you can access the cluster with `kubectl get nodes`. You should get:

```
$ kubectl get nodes
NAME      STATUS    AGE       VERSION
master    Ready     10m       v1.10.3
node1     Ready     9m        v1.10.3
node2     Ready     9m        v1.10.3
node3     Ready     9m        v1.10.3
```



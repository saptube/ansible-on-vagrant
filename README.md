Ansible on Vagrant
==================

This repo will demonstrate how to setup a small environment to **get you started** developing with **Ansible**.

We will create one ansible controller and 4 linux hosts. The linux version used is called **alpine**. Why? Because this is a very small distro. It has an iso of less than 100MB.

We use Vagrant from Hashicorp to interact with the hypervisor. In our example this is VirtualBox.

Logging into vm
---------------

You can use `vagrant ssh-config` to see the available keys and the ports to use.

In our example we will log into the ansible controller using:

`ssh vagrant@localhost -p 2222 -i id_rsa`

Running playbook
----------------

You are now ready to start running your first playbook.

```
# login using password
ssh vagrant@localhost -p 2222
```

When you are in the machine now, you can start the playbook.

```
# switch direcotry
cd /vagrant

# run playbook
ansible-playbook -i inventory.ini playbook.yml
```

Copyright
---------

(C) 2024 saptube
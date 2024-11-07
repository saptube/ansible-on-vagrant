Ansible on Vagrant
==================

This repo will demonstrate how to setup a small environment to **get you started** developing with **Ansible**.

We will create one ansible controller and 4 linux hosts. The linux version used is called **alpine**. Why? Because this is a very small distro. It has an iso of less than 100MB.


Logging into vm
---------------

`vagrant ssh-config`

`ssh vagrant@localhost -p 2222 -i id_rsa`

Running playbook
----------------

You are now ready to start running your first playbook.

```
cd /vagrant
ansible-playbook -i inventory.ini playbook.yml

```
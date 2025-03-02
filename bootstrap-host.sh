#!/bin/sh

echo "hallo" >> /tmp/sjoerd.txt

apk update
apk add openssh python3

mkdir -p /home/vagrant/.ssh
chown -R vagrant:vagrant /home/vagrant/.ssh

# Voeg de publieke sleutel van de controller toe aan authorized_keys
if [ -f /vagrant/id_rsa.pub ]; then
    cat /vagrant/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
    chmod 600 /home/vagrant/.ssh/authorized_keys
fi

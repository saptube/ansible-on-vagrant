#!/bin/sh

echo "hallo" >> /tmp/sjoerd.txt

apk update
apk add ansible openssh

# Genereer SSH-sleutels als deze niet bestaan
if [ ! -f /home/vagrant/.ssh/id_rsa ]; then
sudo -u vagrant ssh-keygen -t rsa -N '' -f /home/vagrant/.ssh/id_rsa
fi

# Kopieer de gegenereerde publieke sleutel naar de /vagrant directory
cp /home/vagrant/.ssh/id_rsa.pub /vagrant/id_rsa.pub

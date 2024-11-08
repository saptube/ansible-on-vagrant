Vagrant.configure("2") do |config|
    # Algemene instellingen
    config.vm.box = "generic/alpine312"  # Alpine 3.12 image
    config.ssh.insert_key = false  # Schakel het toevoegen van Vagrant's standaard SSH-sleutel uit

    # Controller node met Ansible en gedeelde map
    config.vm.define "ansible-controller" do |controller|
      controller.vm.hostname = "ansible-controller"
      controller.vm.network "private_network", ip: "192.168.56.10"
      controller.vm.provider "virtualbox" do |vb|
        vb.name = "ansible_controller"
        vb.memory = 256
      end

      # Map de huidige directory naar /vagrant in de VM
      controller.vm.synced_folder ".", "/vagrant", type: "virtualbox"

      # Provisioning om Ansible te installeren en de sleutels te kopiëren
      controller.vm.provision "shell", inline: <<-SHELL
        apk update
        apk add ansible openssh
        mkdir -p /home/vagrant/.ssh
        chown -R vagrant:vagrant /home/vagrant/.ssh

        # Genereer SSH-sleutels als deze niet bestaan
        if [ ! -f /home/vagrant/.ssh/id_rsa ]; then
          sudo -u vagrant ssh-keygen -t rsa -N '' -f /home/vagrant/.ssh/id_rsa
        fi

        # Kopieer de gegenereerde publieke sleutel naar de /vagrant directory
        cp /home/vagrant/.ssh/id_rsa.pub /vagrant/id_rsa.pub

        # Configureer Ansible om host key checking uit te schakelen
        echo '[defaults]' > /home/vagrant/.ansible.cfg
        echo 'host_key_checking = False' >> /home/vagrant/.ansible.cfg
        chown vagrant:vagrant /home/vagrant/.ansible.cfg
      SHELL
    end

    # Hosts met aangepaste namen en SSH-sleutels
    (1..4).each do |i|
      config.vm.define "host#{i}" do |host|
        host.vm.hostname = "host#{i}"
        host.vm.network "private_network", ip: "192.168.56.1#{i}"
        host.vm.provider "virtualbox" do |vb|
          vb.name = "host#{i}"
          vb.memory = 128
          vb.cpus = 1
        end

        # Map de huidige directory naar /vagrant in de VM
        host.vm.synced_folder ".", "/vagrant", type: "virtualbox"

        host.vm.provision "shell", inline: <<-SHELL
          apk update
          apk add python3 openssh
          mkdir -p /home/vagrant/.ssh
          chown -R vagrant:vagrant /home/vagrant/.ssh

          # Voeg de publieke sleutel van de controller toe aan authorized_keys
          if [ -f /vagrant/id_rsa.pub ]; then
            cat /vagrant/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
            chmod 600 /home/vagrant/.ssh/authorized_keys
          fi

        SHELL
      end
    end
  end

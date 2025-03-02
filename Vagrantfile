Vagrant.configure("2") do |config|
  # Use the Alpine Linux box from Vagrant Cloud
  config.vm.box = "generic-x64/alpine319"
  config.ssh.insert_key = false  # Schakel het toevoegen van Vagrant's standaard SSH-sleutel uit

  # Controller node
  config.vm.define "ansible-controller" do |controller|
      controller.vm.hostname = "ansible-controller"
      controller.vm.network "private_network", ip: "192.168.56.10"
      controller.vm.provider "virtualbox" do |vb|
        vb.name = "ansible_controller"
        vb.memory = 256
      end

      # Bootstrapping script
      controller.vm.provision "shell", path: "bootstrap-controller.sh"

      # Map the current dir to /vagrant inside the VM
      controller.vm.synced_folder ".", "/vagrant", type: "virtualbox"
  end

  # Hosts met aangepaste namen en SSH-sleutels
  (1..3).each do |i|
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

          # Bootstrapping script
          host.vm.provision "shell", path: "bootstrap-host.sh"

      end
  end

end
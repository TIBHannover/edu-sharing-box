
Vagrant.configure("2") do |config|

  config.vm.define "edusharing" do |srv|
    srv.vm.box = "debian/stretch64"
    srv.ssh.insert_key = false
    srv.vm.hostname = "edu-sharing.box"
    #local.vm.synced_folder ".", "/vagrant", create: true, disabled: false
    srv.vm.network :private_network, ip: "192.168.98.101"

    srv.vm.provider :virtualbox do |vb|
      vb.name = "edu-sharing"
      vb.memory = 5120
      vb.cpus = 2
    end
  end

  config.vm.provision "ansible_local" do |ansible|
    ansible.install = true
    ansible.version = "latest"
    ansible.compatibility_mode = "2.0"
    ansible.playbook = "ansible/system.yml"
    ansible.groups = {
      "edusharing" => ["edusharing"],
      "renderingservice" => ["edusharing"]
    }
    ansible.install_mode = "pip"
    #ansible.verbose = "-vvvv"
  end
end

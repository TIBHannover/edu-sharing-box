
Vagrant.configure("2") do |config|

  config.vm.define "local" do |local|
    # local.vm.box = "centos/7"
    local.vm.box = "ubuntu/trusty64"
    # local.vm.box = "bento/ubuntu-16.04"
    local.ssh.insert_key = false
    local.vm.hostname = "edu-sharing-test.box"
    local.vm.synced_folder ".", "/vagrant", create: true, disabled: false
    local.vm.network :private_network, ip: "192.168.98.101"

    local.vm.provider :virtualbox do |vb|
      vb.name = "edu-sharing-test"
      vb.memory = 5120
      vb.cpus = 2
    end
  end

  config.vm.provision "ansible_local" do |ansible|
    ansible.install = true
    ansible.version = "latest"
    ansible.compatibility_mode = "2.0"
    ansible.playbook = "ansible/system.yml"
  end

  #config.vm.provision "file", source: "files/", destination: "$HOME/"
end

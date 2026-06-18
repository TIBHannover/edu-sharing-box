require 'yaml'
settings = YAML.load_file 'ansible/__group_vars/all.yml'


$set_environment_variables = <<SCRIPT
tee "/etc/profile.d/myvars.sh" > "/dev/null" <<EOF
sudo chsh -s /bin/bash vagrant
sed -i "s/#alias ll='ls -l'/alias ll='ls -lAh'/g" /home/vagrant/.bashrc
EOF
SCRIPT


Vagrant.configure("2") do |config|

  config.vm.define "edu-sharing-vm" do |srv|
    srv.vm.box = "cloud-image/debian-13"
    srv.vm.synced_folder ".", "/vagrant" 
    srv.ssh.insert_key = false
    srv.vm.hostname = "edu-sharing.box"
    srv.vm.network :private_network, ip: settings['edu_sharing_host']

    srv.vm.provider :virtualbox do |vb|
      vb.name = "edu-sharing"
      vb.memory = 7168
      vb.cpus = 2
    end
  end

    config.vm.provision "shell", inline: $set_environment_variables
    config.vm.provision "ansible_local" do |ansible|
    ansible.install = true
    ansible.install_mode = "pip"
    ansible.pip_install_cmd = "sudo apt update && sudo apt install python3-pip -y"
    ansible.pip_args = "ansible-core==2.18.9 --break-system-packages"
    ansible.compatibility_mode = "2.0"
    #ansible.verbose = "vvv"
    ansible.playbook = "ansible/system.yml"
    ansible.galaxy_role_file = "requirements.yml"
    ansible.groups = {
      "edusharing" => ["edu-sharing-vm"],
      "opencast" => ["edu-sharing-vm"],
      "all:vars" => {
        "timezone" => "Europe/Berlin"
      }
    }
  end
end

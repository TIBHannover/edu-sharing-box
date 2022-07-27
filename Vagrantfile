require 'yaml'
settings = YAML.load_file 'ansible/group_vars/all.yml'

Vagrant.configure("2") do |config|

  config.vm.define "edu-sharing-vm" do |srv|
    srv.vm.box = "debian/buster64"
    srv.ssh.insert_key = false
    srv.vm.hostname = "edu-sharing.box"
    srv.vm.network :private_network, ip: settings['edu_sharing_host']

    srv.vm.provider :virtualbox do |vb|
      vb.name = "edu-sharing"
      vb.memory = 5120
      vb.cpus = 2
    end
  end

  config.vm.define "esrender-vm" do |srv|
    srv.vm.box = "debian/buster64"
    srv.ssh.insert_key = false
    srv.vm.hostname = "edu-sharing-rendering.box"
    srv.vm.network :private_network, ip: settings['esrender_host']

    srv.vm.provider :virtualbox do |vb|
      vb.name = "edu-sharing-rendering"
      vb.memory = 2024
      vb.cpus = 2
    end
  end

  config.vm.provision "ansible_local" do |ansible|
    ansible.install = true
    ansible.install_mode = "pip"
    ansible.pip_install_cmd = "sudo apt-get install -y python3-distutils && curl -s https://bootstrap.pypa.io/get-pip.py | sudo python3"
    ansible.version = "2.9.27"
    ansible.compatibility_mode = "2.0"
    #ansible.verbose = "vvv"
    ansible.playbook = "ansible/system.yml"
    ansible.galaxy_role_file = "requirements.yml"
    ansible.groups = {
      "alfrescosolr4" => ["edu-sharing-vm"],
      "edusharing" => ["edu-sharing-vm"],
      "onlyoffice" => ["esrender-vm"],
      "opencast" => ["esrender-vm"],
      "renderingservice" => ["esrender-vm"],
      "tomcat:children" => ["alfrescosolr4", "edusharing"],
      "alfresco:children" => ["alfrescosolr4", "edusharing"],
      "all:vars" => {
        "timezone" => "Europe/Berlin"
      }
    }
  end
end

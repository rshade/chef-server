# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "Berkshelf-CentOS-6.3-x86_64-minimal"
  config.vm.box_url = "Berkshelf-CentOS-6.3-x86_64-minimal"

  config.vm.network :private_network, ip: "33.0.0.2"
  
  config.vm.provision :shell,
      inline: <<SCRIPT
        mkdir -p /var/chef/cache /var/chef/cookbooks/chef-server
SCRIPT

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      'chef-server-blueprint' => {
        'version' => :latest,
        'api_fqdn' => "33.0.0.0.2"
      }
    }

    chef.run_list = ['recipe[chef-server::default]']
  end
end

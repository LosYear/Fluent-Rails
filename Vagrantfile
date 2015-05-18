# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "chef/debian-7.8"
  config.vm.network "forwarded_port", guest: 3000, host: 3000
  config.vm.network "forwarded_port", guest: 3306, host: 3306
  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  #config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "../../fluent", "/fluent"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
	
	# if gpg -k | grep -q "4096R/D39DC0E3"; then		
		# printf "RVM: GPG key found\n"
	# else
		# gpg -k
		# gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
	# fi

	# if  ! rvm_loc="$(type -p \"rvm\")" || [ -z "$rvm_loc" ]; then
		# printf "RVM: Not Found, Installing RVM\n"
		# curl -sSL https://get.rvm.io | bash -s stable
		# source /usr/local/rvm/scripts/rvm
		# printf "RVM: Should be installed\n"
	# else
		# printf "RVM: Found\n"
	# fi	

	# if (rvm_loc="$(type -p \"rvm\")" || [ -z "$rvm_loc" ]) && (rvm list | grep -q "2.2"); then
		# printf "RVM: Ruby 2.2 found"
	# else
		# printf "RVM: Ruby 2.2 not found, installing"
		# apt-get update
		# source /usr/local/rvm/scripts/rvm
		# rvm requirements
		# rvm install 2.2
		# rvm create alias default 2.2
		# rvm use default
		# printf "RVM: Ruby 2.2 installed"
	# fi
	
	# if  ! git_loc="$(type -p \"git\")" || [ -z "$git_loc" ]; then
		# printf "Git: Not Found, Installing Git\n"
		# apt-get install git-core -y
		# printf "Git: Should be installed\n"
	# else
		# printf "Git: Found\n"
	# fi	
		
	# if [ ! -f /etc/apt/sources.list.d/babushka.list ]; then
		# touch /etc/apt/sources.list.d/babushka.list
		# chmod 764 /etc/apt/sources.list.d/babushka.list
		# chown vagrant:vagrant /etc/apt/sources.list.d/babushka.list
	# fi
   # SHELL

  # config.vm.provision :babushka do |babushka|
	# # Options for Babushka run
	# babushka.color = true
	# babushka.local_deps_path = 'babushka-deps'
	
	 # babushka.meet 'mysql'#, :source => 'losyear'
	# babushka.meet 'jessie.repo'
	# babushka.meet 'rails', :run_with_sudo => false
  # end
  config.vm.provision :chef_solo do |chef|
	chef.add_recipe "apt"
	chef.add_recipe "nodejs"
	chef.add_recipe "mysql::server"
	chef.add_recipe "mysql::client"
	chef.add_recipe "imagemagick"
	chef.add_recipe "rbenv"
	chef.add_recipe "rbenv::ruby_build"
	chef.add_recipe "rbenv-install-rubies"
	
	chef.json = {
		mysql: {
			server_root_password: '1111',
			allow_remote_root: true,
			enable_utf8: 'true'
		},
		
		rbenv_install_rubies: {
			global_version: "2.2.2",
			gems: ['bundler', 'rails']
		}
	}
  end
end

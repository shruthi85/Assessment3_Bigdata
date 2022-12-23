# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "1.4.3" in Vagrant.configure
# configures the configuration version .
Vagrant.require_version ">= 1.4.3"
VAGRANTFILE_API_VERSION = "2"

#To set up 3 VM Cluster
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	numNodes = 3
	r = numNodes..1
	(r.first).downto(r.last).each do |i|
		config.vm.define "node#{i}" do |node|
			node.vm.box = "bento/ubuntu-20.04"
			node.vm.provider "virtualbox" do |v|
			    v.name = "node#{i}"
			    v.customize ["modifyvm", :id, "--memory", "1536"]
			end
			node.vm.network :private_network, ip: "10.0.2.4#{i}"
			node.vm.hostname = "node#{i}"
			node.vm.provision "shell", path: "scripts/setup-ubuntu.sh"
			node.vm.provision "shell" do |s|
			   s.path = "scripts/setup-ubuntu-hosts.sh"
				s.args = "-t #{numNodes}"
			end
		end
	end
end
			

	

#To set up java,Hadoop and its configuration.Installation of Hive.
			
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	numNodes = 3
	r = numNodes..1
	(r.first).downto(r.last).each do |i|	
        config.vm.define "node#{i}" do |node|			
			node.vm.provision "shell", path: "scripts/apt-refresh.sh"
			node.vm.provision "shell", path: "scripts/setup-java.sh"
			node.vm.provision "shell", path: "scripts/setup-hadoop.sh"
			#run one each
			if i == 1
			#namenode format
              config.vm.provision "shell", inline: "/usr/local/hadoop/bin/hdfs namenode -format"
              config.vm.provision "shell", inline: "/usr/local/hadoop/sbin/start-dfs.sh", run: "always"
			end  
			node.vm.provision "shell" do |s|
			if i > 1
				node.vm.provision "shell" do |s|
				s.path = "scripts/setup-hive.sh"
				end
			end
    end
  end	
end




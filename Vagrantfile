subnet = '192.168.50.'
server_cpus = 1
server_memory = 512

Vagrant.configure('2') do |config|
  config.vm.box = 'centos/7'
  config.vm.box_check_update = false
  config.vm.provider :virtualbox do |vb_config|
    vb_config.memory = server_memory
    vb_config.cpus = server_cpus
    vb_config.gui = false
    vb_config.check_guest_additions = false
  end

  # Config for jenkins
  config.vm.define :jenkins do |jenkins_srv|
    jenkins_srv.vm.provider :virtualbox do |vb_config|
      vb_config.name = 'Jenkins'
    end

    jenkins_srv.vm.provision 'docker'

    jenkins_srv.vm.hostname = 'jenkins'
    jenkins_srv.vm.network :forwarded_port, guest: 8080, host: 8080
    # jenkins_srv.vm.network :forwarded_port, guest: 3000, host: 3000

    # Install Jenkins
    jenkins_srv.vm.provision "ansible_local" do |ansible|      
      ansible.inventory_path = "provision/inventory/hosts"
      ansible.playbook = "provision/jenkins.yml" 
    end

    jenkins_srv.vm.provision 'shell', inline: <<-SHELL
      JENKINSPWD=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)
      echo $JENKINSPWD
    SHELL
    jenkins_srv.vm.network 'private_network', ip: subnet + '2'
  end
end

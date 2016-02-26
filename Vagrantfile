# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "dummy"

  config.vm.synced_folder ".", "/vagrant", type: "rsync",
    rsync__exclude: [
      '.vagrant/',
      '.git/',
      'tmp/',
      'packer_cache/'
  ]

  ## AWS
  config.vm.provider :aws do |aws, override|
    aws.access_key_id = ENV['AWS_ACCESS_KEY']
    aws.secret_access_key = ENV['AWS_SECRET_ACCESS_KEY']
    aws.keypair_name = ENV['AWS_EC2_KEYPAIR']
    aws.user_data = "#!/bin/bash\nsed -i -e 's/^Defaults.*requiretty/# Defaults requiretty/g' /etc/sudoers"

    aws.region = ENV['AWS_REGION']
    aws.instance_type = 'c3.large'
    case ENV['AWS_REGION']
    when 'ap-northeast-1'
      aws.ami = 'ami-59bdb937' # Amazon Linux AMI 2015.09.2 (HVM) SSD
    when 'us-east-1'
      aws.ami = 'ami-8fcee4e5' # Amazon Linux AMI 2015.09.2 (HVM) SSD
    else
      raise "Unsupported region #{ENV['AWS_REGION']}"
    end

    aws.tags = {
      'Name' => "Virtuoso #{ENV['PRODUCT_VERSION']} (Developed by #{ENV['USER']})"
    }

    override.ssh.username = "ec2-user"
    override.ssh.private_key_path = ENV['AWS_EC2_KEYPASS']
  end

  config.ssh.pty = true

  config.vm.provision :shell, :path => "chef_prepare.sh"
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["cookbooks", "site-cookbooks"]
    chef.add_recipe 'simplelog_handler::default'
    chef.add_recipe 'lw1_virtuoso::user_group'
  end

  config.vm.provision :shell, :path => "bootstrap.sh"

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = ["cookbooks", "site-cookbooks"]
    chef.add_recipe 'simplelog_handler::default'
    chef.add_recipe 'lw1_virtuoso::regist_service'
    chef.add_recipe 'lw1_virtuoso::set_initiaize'
  end
#  config.vm.provision :shell, :path => "hotfix.sh"

end

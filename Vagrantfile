BOX = ENV.fetch('BOX', 'debian-6.0')

def debianoid?
  BOX =~ /debian|ubuntu/
end

# See the README.md for plugin installation instructions
Vagrant.require_plugin 'vagrant-berkshelf'
Vagrant.require_plugin 'vagrant-omnibus'

Vagrant.configure('2') do |config|
  config.vm.box = BOX
  config.vm.hostname = 'ruby-pkg'

  config.vm.provider :virtualbox do |v|
    v.customize ['modifyvm', :id, '--memory', 2048]
  end

  config.vm.provider :vmware_fusion do |v|
    v.vmx['memsize'] = 2048
  end

  config.omnibus.chef_version = :latest

  config.vm.provision :chef_solo do |chef|
    chef.log_level = :debug if ENV['DEBUG']

    chef.add_recipe 'apt' if debianoid?

    chef.add_recipe 'ruby_pkg'
    chef.json = {
      :ruby_pkg => {
        :pkg_dir      => '/vagrant/pkg',
        :ruby_version => ENV['VERSION'],
        :iteration    => ENV['ITERATION'],
        :maintainer   => ENV['MAINTAINER']
      }
    }
  end
end

cache_type 'BasicFile'
cache_options(:path => "#{ENV['HOME']}/.chef/checksums")

##
# knife-solo
#
node_path 'nodes'

cookbook_path nil
role_path     nil
data_bag_path nil
encrypted_data_bag_secret nil
environment_path nil

# ~/.berkshelf/knife-solo/*/
knife[:berkshelf_path] = nil

# for knife-ec2 etc.
knife[:solo] = true

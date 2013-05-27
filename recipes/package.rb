#
# Cookbook Name:: ruby_pkg
# Recipe:: package
#
# Author:: Teemu Matilainen <teemu.matilainen@reaktor.fi>
#
# Copyright 2013, Reaktor Innovations Oy
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

node.default['ruby_pkg']['type'] = Chef::RubyPkg::Helpers.default_package_type(node)
node.default['ruby_pkg']['dependencies'] = Chef::RubyPkg::Helpers.default_package_dependencies(node)

unless node['ruby_pkg']['type']
  Chef::Log.fatal 'No package type specified for ruby_pkg::package'
  return
end

include_recipe 'ruby_pkg::_fpm_gemhome'

ruby_base_dir = node['ruby_pkg']['base_dir']
ruby_version_full = node['ruby_pkg']['ruby_version']
ruby_version_main = Chef::RubyPkg::Helpers.main_version(ruby_version_full)

# Configure and include fpm-tng recipe
node.set['fpm_tng']['exec'] = File.join(node['ruby_pkg']['fpm_gemhome'], 'bin', 'fpm')
node.set['fpm_tng']['gem'] = File.join(ruby_base_dir, ruby_version_full, 'bin', 'gem')
node.set['fpm_tng']['package_dir'] = node['ruby_pkg']['pkg_dir']
include_recipe 'fpm-tng'

# Synlink e.g. /usr/local/ruby/1.9.3 -> 1.9.3-p429
link File.join(ruby_base_dir, ruby_version_main) do
  to ruby_version_full
end

ruby_package_path = File.join(
  node['fpm_tng']['package_dir'],
  "#{node['platform']}-#{node['platform_version']}_ruby-FULLVERSION_ARCH.TYPE")

# Build the package
fpm_tng_package "ruby-#{ruby_version_main}" do
  input_type   'dir'
  input_args   [ruby_version_full, ruby_version_main].map { |dir| File.join(ruby_base_dir, dir) }
  output_type  node['ruby_pkg']['type']
  package      ruby_package_path
  version      ruby_version_full
  iteration    node['ruby_pkg']['iteration']
  architecture 'native'
  maintainer   node['ruby_pkg']['maintainer']
  depends      node['ruby_pkg']['dependencies']
end

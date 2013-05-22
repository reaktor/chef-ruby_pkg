#
# Cookbook Name:: ruby_pkg
# Recipe:: _fpm_dependencies
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

node.default['ruby_pkg']['fpm_dependencies'] = Chef::RubyPkg::Helpers.default_fpm_dependencies(node)
dependencies = node['ruby_pkg']['fpm_dependencies']

if !dependencies || dependencies.empty?
  Chef::Log.info 'No fpm dependencies specified'
  return
end

# Ensure package cache is up-to-date
if node['platform_family'] == 'debian'
  include_recipe 'apt'
end

# Reload Ohai's ruby information
ohai 'ruby' do
  plugin 'ruby'
  action :nothing
end

# Install system ruby etc.
dependencies.each do |pkg|
  package pkg do
    notifies :reload, 'ohai[ruby]', :immediately
  end
end

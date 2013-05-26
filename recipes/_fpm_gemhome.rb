#
# Cookbook Name:: ruby_pkg
# Recipe:: _fpm_gemhome
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

fpm_gemhome = node['ruby_pkg']['fpm_gemhome']

directory fpm_gemhome do
  owner 'root'
  group 'root'
  mode 00755
  recursive true
end

ruby_block 'Set GEM_HOME for fpm' do
  block do
    ENV['GEM_HOME'] = fpm_gemhome
  end
  notifies :create, 'ruby_block[Unset GEM_HOME]'
end

ruby_block 'Unset GEM_HOME' do
  block do
    ENV['GEM_HOME'] = nil
  end
  action :nothing
end

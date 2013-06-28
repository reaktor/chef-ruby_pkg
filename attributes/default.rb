#
# Cookbook Name:: ruby_pkg
# Attributes:: default
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

default['ruby_pkg']['ruby_version']     = '1.9.3-p448'
default['ruby_pkg']['iteration']        = 1

default['ruby_pkg']['base_dir']         = '/usr/local/ruby'
default['ruby_pkg']['pkg_dir']          = '/tmp'
default['ruby_pkg']['fpm_gemhome']      = '/usr/local/fpm_gems'

default['ruby_pkg']['maintainer']       = nil

# Real defaults set in the recipes
default['ruby_pkg']['type']             = nil
default['ruby_pkg']['dependencies']     = nil

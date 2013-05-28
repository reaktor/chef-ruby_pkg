#
# Cookbook Name:: ruby_pkg
# Library:: Chef::RubyPkg::Helpers
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

class Chef
  module RubyPkg
    module Helpers
      # Returns the Ruby version number without the patch version
      def self.main_version(full_version)
        full_version[/[^-]*/]
      end

      def self.default_package_type(node)
        case node['platform_family']
        when 'debian'         then 'deb'
        when 'fedora', 'rhel' then 'rpm'
        else
          Chef::Log.warn 'Unsupported platform for ruby_pkg'
          nil
        end
      end

      def self.default_package_dependencies(node)
        case node['platform_family']
        when 'debian'
          deps = %w[libncurses5 libreadline6 zlib1g]
          deps << (pre_wheezy?(node) ? 'libssl0.9.8' : 'libssl1.0.0')
          deps
        when 'rhel'
          %w[libffi openssl readline zlib]
        end
      end

      def self.pre_wheezy?(node)
        node['platform'] == 'debian' && node['platform_version'].to_i < 7
      end
    end
  end
end

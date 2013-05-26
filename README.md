ruby_pkg
========

[![Build Status](https://travis-ci.org/reaktor/chef-ruby_pkg.png?branch=master)](https://travis-ci.org/reaktor/chef-ruby_pkg)
[![Dependency Status](https://gemnasium.com/reaktor/chef-ruby_pkg.png)](https://gemnasium.com/reaktor/chef-ruby_pkg)

Table of Contents
-----------------

* [Description](#description)
* [Requirements](#requirements)
* [Usage](#usage)
    * [knife-solo](#knife-solo)
    * [Vagrant](#vagrant)
* [License and Author](#license-and-author)

Description
-----------

A Chef cookbook with [knife-solo](http://matschaffer.github.io/knife-solo/) and [Vagrant](http://www.vagrantup.com/) setups for building and packaging a specified Ruby version.

Requirements
------------

Should work on all Debian based Linux distributions. Support for some other platforms (that ruby_build and [fpm](https://github.com/jordansissel/fpm) support) is planned. Please open an [issue](https://github.com/reaktor/chef-ruby_pkg/issues) or pull request if interested.

Requires [ruby_build](http://community.opscode.com/cookbooks/ruby_build) and [fpm-tng](http://community.opscode.com/cookbooks/fpm-tng) community cookbooks.

Usage
-----

This cookbook is intended to be used with the included knife-solo or Vagrant setup (although you *can* use the cookbook directly by adding it to run_list or by including it in your own cookbooks).

To use knife-solo or Vagrant you need to use the full [source repository](https://github.com/reaktor/chef-ruby_pkg) version. You can download and extract a [tarball release](https://github.com/reaktor/chef-ruby_pkg/tags) or clone the git repository:

        $ git clone https://github.com/reaktor/chef-ruby_pkg.git ruby_pkg
        $ cd ruby_pkg

### knife-solo

#### Requirements

1. Install Ruby (1.9.3 or later) and [Bundler](http://gembundler.com/)
2. Install knife-solo and dependencies:

        $ bundle install --without development:test

#### Building with knife-solo

1. Copy _./nodes/example.json_ to for example _./nodes/myruby.json_ and edit it to match your wishes
2. Bootstrap the server. Installs Chef and other knife-solo requirements and then builds and packages the specified Ruby version:

        $ bundle exec knife solo bootstrap <user@host> nodes/myruby.json

    You can also use [knife-ec2](https://github.com/opscode/knife-ec2), [knife-digital_ocean](https://github.com/rmoriz/knife-digital_ocean), etc. For example:

        $ gem install knife-ec2
        $ knife ec2 server create --node-name=myruby <other_ec2_options>...
        # note the FQDN/IP for next phase

    If the server is already prepared, you can run only the converge phase:

        $ bundle exec knife solo cook <user@host> nodes/myruby.json

3. Fetch the package from the server. For example:

        $ scp <user@host>:/tmp/debian-7.0_ruby-1.9.3-p429-1_amd64.deb pkg/

### Vagrant

#### Install Vagrant environment

1. Install [Vagrant](http://downloads.vagrantup.com/) v1.2 or later
2. Install needed Vagrant plugins:

        $ vagrant plugin install vagrant-berkshelf
        $ vagrant plugin install vagrant-omnibus

3. Add your favorite Vagrant box, for example:

        $ vagrant box add "ubuntu-12.04" "http://files.vagrantup.com/precise64.box"

#### Building with Vagrant

Spin up the box to build and package a specified Ruby version:

    $ VERSION="1.9.3-p429" BOX="ubuntu-12.04" vagrant up

The package will be created to _pkg_ directory.

#### Environment variables for Vagrant

  * `$BOX` - The Vagrant box name. Defaults to "squeeze-6.0".
  * `$DEBUG` - If set, enable debug logging of the Chef run.
  * `$VERSION` - The Ruby version to package. Passed to ruby_build. Defaults
    to "1.9.3-p429"
  * `$ITERATION` - The package iteration version number. Passed to fpm.
    Defaults to 1.
  * `$MAINTAINER` - The (optional) package maintainer. Passed to fpm.

License and Author
------------------

Author:: Teemu Matilainen <<teemu.matilainen@reaktor.fi>>

Copyright © 2013, [Reaktor Innovations Oy](http://reaktor.fi/en)

Licensed under the Apache License, Version 2.0. See [LICENSE](LICENSE).

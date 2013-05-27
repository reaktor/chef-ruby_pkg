name             'ruby_pkg'
maintainer       'Reaktor Innovations Oy'
maintainer_email 'cookbooks@reaktor.fi'
license          'Apache v2.0'
description      'Builds a ruby package using ruby_build and fpm'
version          '0.3.0'

supports         'debian'
supports         'ubuntu'

depends          'fpm-tng', '~> 0.1.6'
depends          'ruby_build', '~> 0.6'

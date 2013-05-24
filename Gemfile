source 'https://rubygems.org'

gem 'chef', ENV.fetch('CHEF_VERSION', '>= 10')
gem 'foodcritic', '~> 2.0'
gem 'rake'
gem 'tailor', '~> 1.2'

group :development do
  gem 'guard-foodcritic', '>= 1.0.1'
end

group :knife_solo do
  gem 'berkshelf', '~> 1.4'
  gem 'knife-solo', '~> 0.3.0.pre4'
end

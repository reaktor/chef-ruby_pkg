source 'https://rubygems.org'

gem 'chef', ENV.fetch('CHEF_VERSION', '~> 11.0')

group :knife_solo do
  gem 'berkshelf', '~> 1.4'
  gem 'knife-solo', '~> 0.3.0.pre4'
end

group :development, :test do
  gem 'foodcritic', '~> 2.0'
  gem 'rake'
  gem 'tailor', '~> 1.2'
end

group :development do
  gem 'guard-foodcritic', '>= 1.0.1'
  gem 'kitchen-vagrant', '>= 0.10.0'
  gem 'test-kitchen', '>= 1.0.0.alpha.7'
end

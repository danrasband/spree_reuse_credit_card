source 'http://rubygems.org'

gem 'pry'

group :test, :development do
  gem 'rspec-rails'
  gem 'ffaker'
  gem 'spree_auth', '~> 1.0.0'
  gem 'spree_gateway', :git => 'git://github.com/spree/spree_gateway.git'
  gem "factory_girl_rails"
  gem "capybara"
  gem "guard-rspec"
  #gem 'launchy'
end

if RUBY_VERSION < "1.9"
  gem "ruby-debug"
else
  gem "ruby-debug19"
end

gemspec

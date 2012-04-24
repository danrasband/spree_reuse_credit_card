# encoding: UTF-8
Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_reuse_credit_card'
  s.version     = '1.1.0'
  s.summary     = 'Enables view enhancements for managing multiple previously-used credit cards for Spree'
  s.description = 'Enables view enhancements for managing multiple previously-used credit cards for Spree'
  s.required_ruby_version = '>= 1.9.2'

  s.author            = 'Dan Rasband'
  s.email             = 'dan@agencyfusion.com'
  s.homepage          = 'http://agencyfusion.com/'

  #s.files         = `git ls-files`.split("\n")
  #s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency 'spree_core', '>= 1.1.0.rc2'
  s.add_dependency 'spree_auth', '>= 1.1.0.rc2'

  s.add_development_dependency 'capybara', '1.0.1'
  s.add_development_dependency 'factory_girl'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails',  '~> 2.9'
  s.add_development_dependency 'guard-spork'
  s.add_development_dependency 'launchy'
  s.add_development_dependency 'sqlite3'
end


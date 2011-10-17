Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_currency_exchange'
  s.version     = '0.1'
  s.summary     = 'Add multiple currency support to Spree'
  #s.description = 'Add (optional) gem description here'
  s.required_ruby_version = '>= 1.8.7'
  s.author                = 'Fabien Franzen'
  s.required_ruby_version = '>= 1.8.7'
  s.rubygems_version      = '1.3.6'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency('spree_core', '>= 0.70.0')
  s.add_dependency('nokogiri',   '>= 1.4.4')
  s.add_dependency('money',      '>= 3.6.1')
  s.add_dependency('json',       '>= 1.5.1')
  s.add_development_dependency("rspec", ">= 2.5.0")
end

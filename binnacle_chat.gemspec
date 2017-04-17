$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "binnacle_chat/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "binnacle_chat"
  s.version     = BinnacleChat::VERSION
  s.authors     = ["Brian Sam-Bodden"]
  s.email       = ["brian@binnacle.io"]
  s.homepage    = "https://binnacle.io/docs/03_widgets"
  s.summary     = "A Chat Widget for Rails."
  s.description = "A Chat Widget for Rails powered by Binnacle."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'coffee-rails', '~> 4.1', '>= 4.1.0'
  s.add_dependency 'sass-rails', '~> 5.0'
  s.add_dependency 'gon', '~> 6.0', '>= 6.0.1'

  s.add_development_dependency 'sqlite3', '~> 1.3', '>= 1.3.10'
  s.add_development_dependency 'puma', '~> 2', '>= 2.14.0'
end

$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ways/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ways"
  s.version     = Ways::VERSION
  s.authors     = ["Christian Gregor"]
  s.email       = ["chrgregor@gmail.com"]
  s.homepage    = "http://3motic.com"
  s.summary     = "Gather route descriptions with different transport media. Bind to various APIs like Graphhopper, HVV or VBB"
  s.description = "Gather route descriptions with different transport media. Bind to various APIs like Graphhopper, HVV or VBB"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 3.2.22.2"

  s.add_development_dependency "mysql2", '~> 0.3.18'
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec"
  #s.add_development_dependency "rspec-rails"
end

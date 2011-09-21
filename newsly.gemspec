$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "newsly/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "newsly"
  s.version     = Newsly::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of Newsly."
  s.description = "TODO: Description of Newsly."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  
  s.add_dependency "rails", "3.1.0"
  s.add_dependency "resque"
  s.add_dependency "resque_mailer"
  s.add_dependency "liquid"
  s.add_dependency "sanitize"
  s.add_dependency "jquery-rails"  
  #s.add_dependency "mercury-rails"

  s.add_development_dependency "sqlite3"
end

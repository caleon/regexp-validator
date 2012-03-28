$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rexval/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "regexp-validator"
  s.version     = Rexval::VERSION
  s.authors     = ["caleon"]
  s.email       = ["caleon@gmail.com"]
  s.homepage    = "http://github.com/caleon/regexp-validator"
  s.summary     = "Use a centralized file of predefined regular expressions to handle the validation of model fields, routing constraints, etc."
  s.description = "RegexpValidator allows you to centralize the management of all Regular Expression-related validations for your Rails applications."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.1.1"
  s.add_dependency "orm_adapter", "~> 0.0.3"
  s.add_dependency 'core_utilities'

  s.add_development_dependency "sqlite3"
end

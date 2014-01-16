$:.push File.expand_path("../lib", __FILE__)
$:.push File.expand_path("..", __FILE__)

version = File.read(File.expand_path("../VERSION",__FILE__)).strip

Gem::Specification.new do |s|
  s.name        = "active_null_object"
  s.version     = version
  s.email       = "info@stefanroex.nl"
  s.homepage    = "http://stefanroex.nl"
  s.summary     = "Simple null objects in Active Record"
  s.description = ""
  s.authors     = ["Stefan Roex"]

  s.files         = Dir['VERSION', 'README.md', 'lib/**/*']
  s.require_paths = ["lib"]

  s.add_dependency "activerecord", ">= 4.0.0"
  s.add_dependency "activesupport", ">= 4.0.0"

  s.add_development_dependency "rspec"
  s.add_development_dependency "sqlite3"
end

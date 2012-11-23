# encoding: utf-8

Gem::Specification.new do |gem|
  gem.name          = "paperclip-dropbox"
  gem.version       = "1.0.1"
  gem.platform      = Gem::Platform::RUBY

  gem.homepage      = "https://github.com/janko-m/paperclip-dropbox"
  gem.description   = %q{Extends Paperclip with Dropbox storage.}
  gem.summary       = gem.description
  gem.authors       = ["Janko Marohnić"]
  gem.email         = ["janko.marohnic@gmail.com"]

  gem.files         = Dir["lib/**/*"] + ["README.md", "LICENSE", "paperclip-dropbox.gemspec"]
  gem.require_path  = "lib"

  gem.required_ruby_version = ">= 1.9.2"

  gem.license       = "MIT"

  gem.add_dependency "paperclip", "~> 3.1"
  gem.add_dependency "dropbox-sdk", "~> 1.3"

  gem.add_development_dependency "rake", ">= 0.9"
  gem.add_development_dependency "rspec", "~> 2.11"
  gem.add_development_dependency "vcr", "~> 2.2"
  gem.add_development_dependency "fakeweb", "~> 1.3"
  gem.add_development_dependency "activerecord", "~> 3.2"
  gem.add_development_dependency "rack-test", "~> 0.6"
  gem.add_development_dependency "sqlite3", "~> 1.3"
  gem.add_development_dependency "rest-client", "~> 1.6"
end

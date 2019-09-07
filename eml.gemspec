# frozen_string_literal: true

$LOAD_PATH.unshift(::File.join(::File.dirname(__FILE__), "lib"))

require "eml/version"

Gem::Specification.new do |s|
  s.name = "eml"
  s.version = EML::VERSION
  s.required_ruby_version = ">= 2.6.0"
  s.summary = "Ruby bindings for the EML API"
  s.description = "Connect to the EML payments APIs and " \
    "Transaction Notification Serices"
  s.author = "Morning Coffee"
  s.email = "developers@morningcoffee.com.au"
  s.homepage = "https://github.com/MorningCoffeeDev/eml_ruby"
  s.license = "MIT"

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- test/*`.split("\n")
  s.require_paths = ["lib"]

  s.add_dependency "http", "~> 4.0.0"

  s.add_development_dependency "rspec", "~> 3.8"
  s.add_development_dependency "rubocop", "~> 0.71"
  s.add_development_dependency "rubocop-performance"
  s.add_development_dependency "rubocop-rspec"
  s.add_development_dependency "simplecov"
  s.add_development_dependency "vcr"
end

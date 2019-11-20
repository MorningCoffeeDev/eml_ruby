# frozen_string_literal: true

$LOAD_PATH.unshift(::File.join(::File.dirname(__FILE__), "lib"))

require "eml/version"

Gem::Specification.new do |spec|
  spec.name = "eml"
  spec.version = EML::VERSION
  spec.required_ruby_version = ">= 2.6.0"
  spec.summary = "Ruby bindings for the EML API"
  spec.description = "Connect to the EML payments APIs and " \
    "Transaction Notification Serices"
  spec.author = "Morning Coffee"
  spec.email = "developers@morningcoffee.com.au"
  spec.homepage = "https://github.com/MorningCoffeeDev/eml_ruby"
  spec.license = "MIT"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").
      reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ["lib"]

  spec.add_dependency "http", "~> 4.0.0"
  spec.add_dependency "sorbet-runtime"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "dotenv"
  spec.add_development_dependency "faker"
  spec.add_development_dependency "pry-byebug"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.8"
  spec.add_development_dependency "rubocop", "~> 0.71"
  spec.add_development_dependency "rubocop-performance"
  spec.add_development_dependency "rubocop-rspec"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "sorbet"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
end

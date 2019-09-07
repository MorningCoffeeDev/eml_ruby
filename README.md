# EML API integration library for Ruby

The EML API integration library provides convenient access to EML's REST Web
Services and Transaction Notification Service for applications written in
the Ruby language.

Version 1 supports the UK APIs with Australian support coming as existing code
is extracted.

## Installation

You don't need this source code unless you want to modify the gem. If you just
want to use the package, just include the following in your Gemfile:

```sh
gem "eml", github: "MorningCoffeeDev/eml_ruby"
```

If you are debugging or developing this gem and wish to use it within the
context of an existing application, modify your Gemfile to read:

```sh
gem "eml", path: "../path_to_gem"
```

### Requirements

- Ruby 2.6+ (untested in prior versions)

## Usage

Each geographical region is a separate module and will need to be configured
with your supplied credentials.

```ruby
require "eml"

EML::UK.configure do |config|
  config.username = "username"
  config.password = "password"
  config.merchant = "merchant_id"
  config.program = "program_id"
end
```

Make sure you never commit your credentials to git. If you are using Ruby on
Rails, it is usually best to keep your secrets in your
[credentials file]: https://edgeguides.rubyonrails.org/security.html#custom-credentials

## Development

Since it is necessary to authenticate with EML to test API resources,
credentials and a test card ID are required. The dotenv gem is loaded when tests
are run and will look for a .env file in the root directory. A .env.example file
has been supplied so you copy it to .env and replace the example values:

```sh
cp .env.example .env
```

The .env file has been added to the .gitignore list and should never been
commited to the repository.

Run all tests:

```sh
bundle exec rspec
```

Run a single test suite:

```sh
bundle exec rspec spec/path/to/file.rb
```

Run a single test, include the line number:

```sh
bundle exec rspec spec/path/to/file.rb:123
```

Please ensure that all changes have been run by the Rubocop before creating a
pull request:

```sh
bundle exec rubocop
```

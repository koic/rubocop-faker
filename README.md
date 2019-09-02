# RuboCop Faker

[![Gem Version](https://badge.fury.io/rb/rubocop-faker.svg)](https://badge.fury.io/rb/rubocop-faker)
[![CircleCI](https://circleci.com/gh/koic/rubocop-faker.svg?style=svg)](https://circleci.com/gh/koic/rubocop-faker)

A [RuboCop](https://github.com/rubocop-hq/rubocop) extension for [Faker](https://github.com/faker-ruby/faker).

RuboCop Faker is a tool for converting your Faker's methods to the latest Faker argument style with static code analysis.

With RuboCop Faker you can upgrade your Faker 1 codes to Faker 2 in no time. It supports [conversions](https://github.com/koic/rubocop-faker/blob/master/config/default.yml) for almost all of the Faker 2 changes.

## Installation

Just install the `rubocop-faker` gem

```sh
gem install rubocop-faker
```

or if you use bundler put this in your `Gemfile`

```ruby
gem 'rubocop-faker'
```

## Examples

Here's an example.

```ruby
Faker::Avatar.image(slug, size, format, set, bgset)
```

RuboCop Faker would convert it to the following Faker 2 form:

```ruby
Faker::Avatar.image(slug: slug, size: size, format: format, set: set, bgset: bgset)
```

## Usage

You need to tell RuboCop to load the Faker extension.

This gem offers the only `Faker/DeprecatedArguments` cop. It is intended to convert a Faker 2 compatible interface.

### Command line

Check positional argument style before Faker 2.

```console
% rubocop --require rubocop-faker --only Faker/DeprecatedArguments
```

Auto-correction to keyword argument style on Faker 2.

```console
% rubocop --require rubocop-faker --only Faker/DeprecatedArguments --auto-correct
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/koic/rubocop-faker.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

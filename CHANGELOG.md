# Change log

## master (unreleased)

## 1.2.0 (2024-10-22)

### Bug fixes

* [#7](https://github.com/koic/rubocop-faker/issues/7): Suppress RuboCop's deprecation warning. ([@koic][])

### Changes

* Drop support for Ruby 2.6 and lower. ([@koic][])

## 1.1.0 (2020-06-11)

### Bug fixes

* Fix a typo for `Faker::Vehicle`'s `state_abbreviation` kwarg. ([@koic][])

### Changes

* Require Faker 2.1.2 or higher. ([@koic][])
* Drop support for RuboCop 0.81 or lower. ([@koic][])

## 1.0.0 (2020-03-14)

### New features

* [#3](https://github.com/koic/rubocop-faker/issues/3): Make `Faker/DeprecatedArguments` aware of `Faker::Base.unique`. ([@koic][])

## 0.2.0 (2019-09-04)

### Bug fixes

* Fix a problem that config/default.yml setting is not applied if .rubocop.yml does not exist when `rubocop --require rubocop-faker` option is used. ([@koic][])

## 0.1.0 (2019-09-02)

### New features

* Create RuboCop Faker gem. ([@koic][])

[@koic]: https://github.com/koic

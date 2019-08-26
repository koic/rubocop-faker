# frozen_string_literal: true

require 'rubocop'

require_relative 'rubocop/faker'
require_relative 'rubocop/faker/version'
require_relative 'rubocop/faker/inject'

RuboCop::Faker::Inject.defaults!

require_relative 'rubocop/cop/faker_cops'

# frozen_string_literal: true

require_relative 'lib/rubocop/faker/version'

Gem::Specification.new do |spec|
  spec.name          = 'rubocop-faker'
  spec.version       = RuboCop::Faker::VERSION
  spec.authors       = ['Koichi ITO']
  spec.email         = ['koic.ito@gmail.com']

  spec.summary       = 'A RuboCop extension for Faker.'
  spec.description   = 'A RuboCop extension for Faker.'
  spec.homepage      = 'https://github.com/koic/rubocop-faker'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.7.0')

  spec.metadata = {
    'homepage_uri' => spec.homepage,
    'rubygems_mfa_required' => 'true',
    'default_lint_roller_plugin' => 'RuboCop::Faker::Plugin'
  }

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'faker', '>= 2.12.0'
  spec.add_dependency 'lint_roller', '~> 1.1'
  spec.add_dependency 'rubocop', '>= 1.72.1'
end

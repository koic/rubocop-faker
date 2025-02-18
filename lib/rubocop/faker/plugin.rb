# frozen_string_literal: true

require 'lint_roller'

module RuboCop
  module Faker
    # A plugin that integrates RuboCop Faker with RuboCop's plugin system.
    class Plugin < LintRoller::Plugin
      def about
        LintRoller::About.new(
          name: 'rubocop-faker',
          version: VERSION,
          homepage: 'https://github.com/koic/rubocop-faker',
          description: 'A RuboCop extension for Faker.'
        )
      end

      def supported?(context)
        context.engine == :rubocop
      end

      def rules(_context)
        LintRoller::Rules.new(
          type: :path,
          config_format: :rubocop,
          value: Pathname.new(__dir__).join('../../../config/default.yml')
        )
      end
    end
  end
end

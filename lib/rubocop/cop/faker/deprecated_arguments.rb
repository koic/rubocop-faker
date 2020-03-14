# frozen_string_literal: true

module RuboCop
  module Cop
    module Faker
      #
      # Checks that Faker arguments style is based on Faker 2.
      # Use keyword arguments instead of positional arguments.
      #
      # @example
      #   # bad
      #   Avatar.image(slug, size, format)
      #
      #   # good
      #   Avatar.image(slug: slug, size: size, format: format)
      #
      class DeprecatedArguments < Cop
        include RangeHelp

        MSG = 'Passing `%<arg>s` with the %<index>s argument of ' \
              '`%<class_name>s.%<method_name>s` is deprecated. ' \
              'Use keyword argument like `%<class_name>s.%<method_name>s' \
              '(%<keyword>s: %<arg>s)` instead.'

        def on_send(node)
          return unless node.receiver

          class_name = faker_class_name(node)

          return unless (methods = argument_keywords[class_name])

          node = node.parent if unique_generator_method?(node)

          return unless (keywords = methods[node.method_name.to_s])

          node.arguments.each_with_index do |argument, index|
            next if argument.hash_type?

            message = format_message(
              keyword: keywords[index], arg: argument.source,
              class_name: class_name, index: index,
              method_name: node.method_name
            )

            add_offense_for_arguments(node, argument, message)
          end
        end

        def autocorrect(node)
          methods = argument_keywords[faker_class_name(node)]
          keywords = methods[node.method_name.to_s]

          kwargs = build_kwargs_style(node, keywords)

          lambda do |corrector|
            corrector.replace(arguments_range(node), kwargs)
          end
        end

        private

        def unique_generator_method?(node)
          node.method?(:unique) && node.arguments.size.zero?
        end

        def format_message(keyword:, arg:, index:, class_name:, method_name:)
          i = case index
              when 0 then '1st'
              when 1 then '2nd'
              when 2 then '3rd'
              else "#{index + 1}th"
              end
          format(
            MSG,
            keyword: keyword,
            arg: arg,
            index: i,
            class_name: class_name,
            method_name: method_name
          )
        end

        def add_offense_for_arguments(node, argument, message)
          add_offense(
            node,
            location: argument.source_range,
            message: message
          )
        end

        def build_kwargs_style(node, keywords)
          node.arguments.map.with_index do |positional_argument, index|
            if positional_argument.hash_type?
              positional_argument.source
            else
              "#{keywords[index]}: #{positional_argument.source}"
            end
          end.join(', ')
        end

        def faker_class_name(node)
          if node.children.first.send_type? && node.children.first.method?(:unique)
            node.children.first.receiver.source
          else
            node.receiver.source
          end
        end

        def arguments_range(node)
          arguments = node.arguments

          range_between(
            arguments.first.source_range.begin_pos,
            arguments.last.source_range.end_pos
          )
        end

        def argument_keywords
          cop_config.fetch('ArgumentKeywords')
        # Workaround for a problem that config/default.yml setting is not applied
        # if .rubocop.yml does not exist when `rubocop --require rubocop-faker`
        # option is used.
        rescue KeyError
          config = File.read(
            File.join(File.dirname(__FILE__), '../../../../config/default.yml')
          )
          yaml = YAML.safe_load(config)

          yaml[cop_name].fetch('ArgumentKeywords', {})
        end
      end
    end
  end
end

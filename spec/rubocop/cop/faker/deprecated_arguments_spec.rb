# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Faker::DeprecatedArguments, :config do
  # RuboCop::ConfigLoader.default_configuration['Faker/DeprecatedArguments']
  let(:cop_config) do
    {
      'ArgumentKeywords' => {
        'Faker::Avatar' => {
          'image' => %w[
            slug size format set bgset
          ]
        }
      }
    }
  end

  it 'does not register an offense when using keyword arguments' do
    expect_no_offenses(<<~RUBY)
      Faker::Avatar.image(slug: slug, size: size, format: format, set: set, bgset: bgset)
    RUBY
  end

  it 'registers an offense when using a positional argument' do
    expect_offense(<<~RUBY)
      Faker::Avatar.image(slug)
                          ^^^^ Passing `slug` with the 1st argument of `Faker::Avatar.image` is deprecated. Use keyword argument like `Faker::Avatar.image(slug: slug)` instead.
    RUBY

    expect_correction(<<~RUBY)
      Faker::Avatar.image(slug: slug)
    RUBY
  end

  it 'registers an offense when using a positional argument with safe navigation' do
    expect_offense(<<~RUBY)
      Faker::Avatar&.image(slug)
                           ^^^^ Passing `slug` with the 1st argument of `Faker::Avatar.image` is deprecated. Use keyword argument like `Faker::Avatar.image(slug: slug)` instead.
    RUBY

    expect_correction(<<~RUBY)
      Faker::Avatar&.image(slug: slug)
    RUBY
  end

  it 'registers an offense ' \
     'when keyword name and actual argument name are different' do
    expect_offense(<<~RUBY)
      Faker::Avatar.image(arg)
                          ^^^ Passing `arg` with the 1st argument of `Faker::Avatar.image` is deprecated. Use keyword argument like `Faker::Avatar.image(slug: arg)` instead.
    RUBY

    expect_correction(<<~RUBY)
      Faker::Avatar.image(slug: arg)
    RUBY
  end

  it 'registers an offense when using a positional argument with a kwarg' do
    expect_offense(<<~RUBY)
      Faker::Avatar.image(slug, size: size, format: format)
                          ^^^^ Passing `slug` with the 1st argument of `Faker::Avatar.image` is deprecated. Use keyword argument like `Faker::Avatar.image(slug: slug)` instead.
    RUBY

    expect_correction(<<~RUBY)
      Faker::Avatar.image(slug: slug, size: size, format: format)
    RUBY
  end

  it 'registers an offense when using a positional arguments' do
    expect_offense(<<~RUBY)
      Faker::Avatar.image(slug, size, format, set, bgset)
                                                   ^^^^^ Passing `bgset` with the 5th argument of `Faker::Avatar.image` is deprecated. Use keyword argument like `Faker::Avatar.image(bgset: bgset)` instead.
                                              ^^^ Passing `set` with the 4th argument of `Faker::Avatar.image` is deprecated. Use keyword argument like `Faker::Avatar.image(set: set)` instead.
                                      ^^^^^^ Passing `format` with the 3rd argument of `Faker::Avatar.image` is deprecated. Use keyword argument like `Faker::Avatar.image(format: format)` instead.
                                ^^^^ Passing `size` with the 2nd argument of `Faker::Avatar.image` is deprecated. Use keyword argument like `Faker::Avatar.image(size: size)` instead.
                          ^^^^ Passing `slug` with the 1st argument of `Faker::Avatar.image` is deprecated. Use keyword argument like `Faker::Avatar.image(slug: slug)` instead.
    RUBY

    expect_correction(<<~RUBY)
      Faker::Avatar.image(slug: slug, size: size, format: format, set: set, bgset: bgset)
    RUBY
  end

  context 'using `Faker::Base.unique`' do
    it 'registers an offense when using a positional argument' do
      expect_offense(<<~RUBY)
        Faker::Avatar.unique.image(slug)
                                   ^^^^ Passing `slug` with the 1st argument of `Faker::Avatar.image` is deprecated. Use keyword argument like `Faker::Avatar.image(slug: slug)` instead.
      RUBY

      expect_correction(<<~RUBY)
        Faker::Avatar.unique.image(slug: slug)
      RUBY
    end
  end
end

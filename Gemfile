# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gemspec

gem 'rake'
gem 'rspec'
gem 'rubocop', github: 'rubocop/rubocop'
gem 'rubocop-performance', '~> 1.22.0'
# Workaround for YARD 0.9.20 or lower.
# It specifies `github` until the release that includes the following changes:
# https://github.com/lsegal/yard/pull/1290
gem 'yard', github: 'lsegal/yard', ref: '10a2e5b'

# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  minimum_coverage 95
end

require 'rspec'
require 'yaml'
require_relative '../autoload'
require_relative 'codebreaker/helpers/values_for_testing'
require_relative 'codebreaker/helpers/common_helpers'

require 'bundler/setup'
require 'codebreaker_marian'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'simplecov'
require 'simplecov-lcov'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
  [
    SimpleCov::Formatter::HTMLFormatter,
    SimpleCov::Formatter::LcovFormatter
  ]
)

SimpleCov::Formatter::LcovFormatter.config do |c|
  c.report_with_single_file = true
  c.single_report_path = 'coverage/lcov.info'
end

if ENV['COVERAGE']
  SimpleCov.start do
    add_filter '/test/'
  end
end

require 'koine/di'

ENV.delete('VIM')

RSpec.configure do |config|
  # config.expect_with :rspec do |expectations|
  #   expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  # end

  # config.mock_with :rspec do |mocks|
  #   mocks.verify_partial_doubles = true
  # end

  # config.shared_context_metadata_behavior = :apply_to_host_groups

  # config.profile_examples = 10
  config.order = :random
end

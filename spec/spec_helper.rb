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
require 'rspec'
ENV.delete('VIM')

RSpec.configure do |config|
  config.order = :random
end

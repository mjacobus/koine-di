$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

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

if ENV['COVERALLS']
  require 'coveralls'
  Coveralls.wear!
end

if ENV['COVERAGE']
  require 'simplecov'

  SimpleCov.start do
    add_filter '/test/'
  end
end

if ENV['SCRUTINIZER']
  require 'scrutinizer/ocular'
  Scrutinizer::Ocular.watch!
end

require 'koine/di'
require 'minitest/autorun'
require 'minitest/reporters'

ENV.delete('VIM')
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(color: true)]

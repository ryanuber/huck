require 'simplecov'
require 'tempfile'
require 'tmpdir'

SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter
SimpleCov.start do
  add_filter '/spec/'
end

require 'huck'

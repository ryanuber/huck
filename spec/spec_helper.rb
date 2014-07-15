require 'simplecov'
require 'tempfile'
require 'tmpdir'

SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter
SimpleCov.start do
  add_filter '/spec/'
end

require 'huck'

def mktempfile content
  f = Tempfile.new 'huck'
  f.write content
  f.close
  f.path
end

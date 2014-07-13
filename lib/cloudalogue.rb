require 'json'
require 'yaml'

require 'cloudalogue/version'
require 'cloudalogue/util'
require 'cloudalogue/generator'
require 'cloudalogue/generators/facter'
require 'cloudalogue/generators/ohai'
require 'cloudalogue/submitter'
require 'cloudalogue/submitters/sqs'

module Cloudalogue

  # Main method to run Cloudalogue and dump info
  def self.run kwargs = {}
    gen_name = Cloudalogue::getarg kwargs, :generator, nil
    g = Generator::factory gen_name
    g.dump
  end

end

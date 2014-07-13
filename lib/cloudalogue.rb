require 'cloudalogue/version'
require 'cloudalogue/util'
require 'cloudalogue/generator'
require 'cloudalogue/facter_generator'
require 'cloudalogue/ohai_generator'
require 'cloudalogue/submitter'
require 'cloudalogue/sqs_submitter'

module Cloudalogue

  # Main method to run Cloudalogue and dump info
  def self.run kwargs = {}
    gen_name = Cloudalogue::getarg kwargs, :generator, nil
    g = Generator::factory gen_name
    g.dump
  end

end

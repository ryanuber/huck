require 'json'
require 'yaml'

require 'cloudalogue/version'
require 'cloudalogue/util'
require 'cloudalogue/generator'
require 'cloudalogue/generators/facter'
require 'cloudalogue/generators/ohai'
require 'cloudalogue/submitter'
require 'cloudalogue/submitters/sqs'
require 'cloudalogue/receiver'
require 'cloudalogue/receivers/sqs'

module Cloudalogue

  # Main method to run Cloudalogue and dump info
  def self.run kwargs = {}
    gen_name = Cloudalogue::getarg kwargs, :generator, nil
    g = Generator::factory gen_name
    g.dump
  end

  def self.serve kwargs = {}
    recv_name = Cloudalogue::getarg kwargs, :receiver, nil
    r = Receiver::factory recv_name
    r.receive do |msg|
      puts msg
    end
  end

end

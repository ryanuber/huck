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
  #
  # == Parameters:
  # generator::
  #   The name of the generator to use (default=facter)
  #
  def self.run kwargs = {}
    config = Cloudalogue::config
    if config.has_key? 'generator'
      gen_name = config['generator']
    end

    gen_arg = Cloudalogue::getarg kwargs, :generator, nil
    gen_name = gen_arg if !gen_arg.nil?

    g = Generator::factory gen_name

    if config.has_key? 'submitter'
      subm_name = config['submitter']
    end

    subm_arg = Cloudalogue::getarg kwargs, :submitter, nil
    subm_name = subm_arg if !subm_arg.nil?

    s = Submitter::factory subm_name
    s.submit g.dump
  end

  # Main method to receive messages from a Cloudalogue client
  #
  # == Parameters:
  # receiver::
  #   The receiver to use (default=sqs)
  #
  def self.serve kwargs = {}
    config = Cloudalogue::config
    if config.has_key? 'receiver'
      recv_name = config['receiver']
    end

    recv_arg = Cloudalogue::getarg kwargs, :receiver, nil
    recv_name = recv_arg if !recv_arg.nil?

    r = Receiver::factory recv_name
    r.receive do |msg|
      puts msg
    end
  end

end

require 'json'
require 'yaml'

require 'cloudalogue/version'
require 'cloudalogue/util'
require 'cloudalogue/generator'
require 'cloudalogue/generators/facter'
require 'cloudalogue/generators/ohai'
require 'cloudalogue/sender'
require 'cloudalogue/senders/sqs'
require 'cloudalogue/receiver'
require 'cloudalogue/receivers/sqs'
require 'cloudalogue/handler'
require 'cloudalogue/handlers/exec'

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

    if config.has_key? 'sender'
      send_name = config['sender']
    end

    send_arg = Cloudalogue::getarg kwargs, :sender, nil
    send_name = send_arg if !send_arg.nil?

    s = Sender::factory send_name
    s.send g.dump
  end

  # Main method to receive messages from a Cloudalogue client
  #
  # == Parameters:
  # receiver::
  #   The receiver to use (default=sqs)
  #
  def self.serve kwargs = {}
    config = Cloudalogue::config
    if config.has_key? 'handler'
      hand_name = config['handler']
    end

    hand_arg = Cloudalogue::getarg kwargs, :handler, nil
    hand_name = hand_arg if !hand_arg.nil?
    h = Handler::factory hand_name

    if config.has_key? 'receiver'
      recv_name = config['receiver']
    end

    recv_arg = Cloudalogue::getarg kwargs, :receiver, nil
    recv_name = recv_arg if !recv_arg.nil?

    r = Receiver::factory recv_name
    r.receive do |msg|
      h.handle msg
    end
  end

end

require 'json'
require 'yaml'

require 'huck/version'
require 'huck/util'
require 'huck/generator'
require 'huck/generators/facter'
require 'huck/generators/ohai'
require 'huck/sender'
require 'huck/senders/sqs'
require 'huck/receiver'
require 'huck/receivers/sqs'
require 'huck/handler'
require 'huck/handlers/exec'

module Huck

  # Main method to run Huck and dump info
  #
  # == Parameters:
  # generator::
  #   The name of the generator to use (default=facter)
  #
  def self.run kwargs = {}
    config = Huck::config
    if config.has_key? 'generator'
      gen_name = config['generator']
    end

    gen_arg = Huck::getarg kwargs, :generator, nil
    gen_name = gen_arg if !gen_arg.nil?

    g = Generator::factory gen_name

    if config.has_key? 'sender'
      send_name = config['sender']
    end

    send_arg = Huck::getarg kwargs, :sender, nil
    send_name = send_arg if !send_arg.nil?

    s = Sender::factory send_name
    s.send g.dump
  end

  # Main method to receive messages from a Huck client
  #
  # == Parameters:
  # receiver::
  #   The receiver to use (default=sqs)
  #
  def self.serve kwargs = {}
    config = Huck::config
    if config.has_key? 'handler'
      hand_name = config['handler']
    end

    hand_arg = Huck::getarg kwargs, :handler, nil
    hand_name = hand_arg if !hand_arg.nil?
    h = Handler::factory hand_name

    if config.has_key? 'receiver'
      recv_name = config['receiver']
    end

    recv_arg = Huck::getarg kwargs, :receiver, nil
    recv_name = recv_arg if !recv_arg.nil?

    r = Receiver::factory recv_name
    r.receive do |msg|
      h.handle msg
    end
  end

end
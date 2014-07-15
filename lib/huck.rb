require 'json'
require 'yaml'

require 'huck/version'
require 'huck/util'
require 'huck/generator'
require 'huck/generators/basic'
require 'huck/generators/facter'
require 'huck/generators/ohai'
require 'huck/generators/yaml'
require 'huck/generators/json'
require 'huck/sender'
require 'huck/senders/sqs'
require 'huck/receiver'
require 'huck/receivers/sqs'
require 'huck/handler'
require 'huck/handlers/echo'
require 'huck/handlers/exec'

module Huck

  # Main method to run Huck and dump info
  #
  # == Parameters:
  # config::
  #   Configuration file path
  # generator::
  #   The name of the generator to use
  # sender::
  #   The name of the sender to use
  #
  def self.run kwargs = {}
    config = Huck::getarg kwargs, :config, nil
    if config.nil?
      conf_file = Huck::getarg kwargs, :config_file, nil
      config = Huck::config :path => conf_file
    end

    if config.has_key? 'generator'
      gen_name = config['generator']
    end
    gen_arg = Huck::getarg kwargs, :generator, nil
    gen_name = gen_arg if !gen_arg.nil?
    g = Generator::factory :name => gen_name, :config => config

    if config.has_key? 'sender'
      send_name = config['sender']
    end
    send_arg = Huck::getarg kwargs, :sender, nil
    send_name = send_arg if !send_arg.nil?
    s = Sender::factory :name => send_name, :config => config

    s.send g.dump
  end

  # Main method to receive messages from a Huck client. If a block is given, the
  # block will be used as the handler code. Otherwise, the configured handler
  # or default handler will be used.
  #
  # == Parameters:
  # receiver::
  #   The receiver to use (default=sqs)
  #
  def self.serve kwargs = {}
    config = Huck::getarg kwargs, :config, nil
    if config.nil?
      conf_file = Huck::getarg kwargs, :config_file, nil
      config = Huck::config :path => conf_file
    end

    if config.has_key? 'handler'
      hand_name = config['handler']
    end
    hand_arg = Huck::getarg kwargs, :handler, nil
    hand_name = hand_arg if !hand_arg.nil?
    h = Handler::factory :name => hand_name, :config => config

    if config.has_key? 'receiver'
      recv_name = config['receiver']
    end
    recv_arg = Huck::getarg kwargs, :receiver, nil
    recv_name = recv_arg if !recv_arg.nil?
    r = Receiver::factory :name => recv_name, :config => config

    begin
      r.receive do |msg|
        block_given? ? yield(msg) : h.handle(msg)
      end
    rescue Interrupt, SystemExit, IRB::Abort
      return
    end
  end

end

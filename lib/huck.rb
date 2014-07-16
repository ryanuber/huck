require 'json'
require 'yaml'

require 'huck/version'
require 'huck/util'
require 'huck/generator'
require 'huck/generators/basic'
require 'huck/generators/facter'
require 'huck/generators/ohai'
require 'huck/generators/file'
require 'huck/generators/exec'
require 'huck/sender'
require 'huck/senders/sqs'
require 'huck/senders/rabbitmq'
require 'huck/receiver'
require 'huck/receivers/sqs'
require 'huck/receivers/rabbitmq'
require 'huck/handler'
require 'huck/handlers/echo'
require 'huck/handlers/exec'

module Huck

  # Main method to run Huck and dump info. If a block is given, the block will
  # be used as the generator code. If no block is passed, then the configured
  # generator will be invoked instead.
  #
  # == Parameters:
  # config_file::
  #   Configuration file path
  # config::
  #   Configuration hash to use in place of a config file
  #
  def self.run kwargs = {}
    config = Huck::getarg kwargs, :config, nil
    if config.nil?
      conf_file = Huck::getarg kwargs, :config_file, nil
      config = Huck::config :path => conf_file
    end

    # Prep the sender
    if config.has_key? 'sender'
      send_name = config['sender']
    end
    send_arg = Huck::getarg kwargs, :sender, nil
    send_name = send_arg if !send_arg.nil?
    s = Sender::factory :name => send_name, :config => config

    # Create an array of generators to execute
    gen_list = config.has_key?('generators') ? config['generators'] : ['basic']
    generators = Array.new
    Huck::parse_providers gen_list do |gen_name, gen_config|
      generators << Generator::factory(:name => gen_name, :config => gen_config)
    end

    # Execute the generators and send their output
    generators.each do |g|
      data = block_given? ? yield : g.generate
      if !data.kind_of? String
        raise RuntimeError, "generator produced non-string result: #{data.class}"
      end
      s.send data
    end
  end

  # Main method to receive messages from a Huck client. If a block is given, the
  # block will be used as the handler code. Otherwise, the configured handler
  # or default handler will be used.
  #
  # == Parameters:
  # config_file::
  #   Configuration file path
  # config::
  #   Configuration hash to use in place of a config file
  #
  def self.serve kwargs = {}, &block
    config = Huck::getarg kwargs, :config, nil
    if config.nil?
      conf_file = Huck::getarg kwargs, :config_file, nil
      config = Huck::config :path => conf_file
    end

    # Create an array of handlers to run when messages arrive
    hand_list = config.has_key?('handlers') ? config['handlers'] : ['echo']
    handlers = Array.new
    Huck::parse_providers hand_list do |hand_name, hand_config|
      handlers << Handler::factory(:name => hand_name, :config => hand_config)
    end

    # Prep the receiver
    if config.has_key? 'receiver'
      recv_name = config['receiver']
    end
    recv_arg = Huck::getarg kwargs, :receiver, nil
    recv_name = recv_arg if !recv_arg.nil?
    receiver = Receiver::factory :name => recv_name, :config => config

    receiver.accept handlers, block
  end

end

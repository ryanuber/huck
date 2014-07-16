module Huck

  # The base sender class
  class Sender
    attr_accessor :config

    # Given a sender's name (or no name), return a new sender instance
    #
    # == Parameters:
    # name::
    #   The name of the sender, or nil to guess
    # config::
    #   A configuration hash
    #
    # == Returns:
    # A Huck::Sender instance
    #
    def self.factory kwargs = {}
      name = Huck::getarg kwargs, :name, nil
      config = Huck::getarg kwargs, :config, nil

      name = 'sqs' if name.nil?

      case name
      when 'sqs'
        s = Senders::SQSSender.new
      when 'rabbitmq'
        s = Senders::RabbitMQSender.new
      else
        raise RuntimeError, "bad sender: #{name}"
      end

      s.config = config
      return s
    end

  end
end

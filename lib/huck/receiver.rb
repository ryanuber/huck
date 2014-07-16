module Huck

  # Base receiver class
  class Receiver
    attr_accessor :config

    # Given a receiver's name (or no name), return a new receiver instance
    #
    # == Parameters:
    # name::
    #   The name of the receiver, or nil to guess
    # config::
    #   A configuration hash
    #
    # == Returns:
    # A Huck::Receiver instance
    #
    def self.factory kwargs = {}
      name = Huck::getarg kwargs, :name, nil
      config = Huck::getarg kwargs, :config, nil

      name = 'sqs' if name.nil?

      case name
      when 'sqs'
        r = Receivers::SQSReceiver.new
      when 'rabbitmq'
        r = Receivers::RabbitMQReceiver.new
      else
        raise RuntimeError, "bad receiver: #{name}"
      end

      r.config = config
      return r
    end

  end
end

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

      if name.nil?
        if Huck::try_load 'aws-sdk'
          name = 'sqs'
        else
          raise RuntimeError, 'unable to load any receivers'
        end
      end

      case name
      when 'sqs'
        r = Receivers::SQSReceiver.new
      else
        raise RuntimeError, "bad receiver: #{name}"
      end

      r.config = config
      return r
    end

  end
end

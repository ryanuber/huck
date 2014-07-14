module Huck

  # Base receiver class
  class Receiver

    # Given a receiver's name (or no name), return a new receiver instance
    #
    # == Parameters:
    # name::
    #   The name of the receiver, or nil to guess
    #
    # == Returns:
    # A Huck::Receiver instance
    #
    def self.factory name
      if name.nil?
        if Huck::try_load 'aws-sdk'
          name = 'sqs'
        else
          raise RuntimeError, 'unable to load any receivers'
        end
      end

      case name
      when 'sqs'
        recv = Receivers::SQSReceiver.new
      else
        raise RuntimeError, "bad receiver: #{name}"
      end

      return recv
    end

  end
end

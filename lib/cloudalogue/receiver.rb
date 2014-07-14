module Cloudalogue

  # Base receiver class
  class Receiver

    # Given a receiver's name (or no name), return a new receiver instance
    #
    # == Parameters:
    # name::
    #   The name of the receiver, or nil to guess
    #
    # == Returns:
    # A Cloudalogue::Receiver instance
    #
    def self.factory name
      if name.nil?
        if Cloudalogue::try_load 'aws-sdk'
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

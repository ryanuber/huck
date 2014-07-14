module Huck

  # The base sender class
  class Sender

    # Given a sender's name (or no name), return a new sender instance
    #
    # == Parameters:
    # name::
    #   The name of the sender, or nil to guess
    #
    # == Returns:
    # A Huck::Sender instance
    #
    def self.factory name
      if name.nil?
        if Huck::try_load 'aws-sdk'
          name = 'sqs'
        else
          raise RuntimeError, 'unable to load any senders'
        end
      end

      case name
      when 'sqs'
        send = Senders::SQSSender.new
      else
        raise RuntimeError, "bad sender: #{name}"
      end

      return send
    end

  end
end

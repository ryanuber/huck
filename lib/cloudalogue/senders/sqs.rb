module Cloudalogue

  module Senders

    # A sender that talks to Amazon Simple Queue Service
    class SQSSender < Sender

      # Includes all required modules for the SQS sender
      def initialize
        require 'aws-sdk'
      end

      # Ensures that configuration is set properly before trying to use the
      # connection data to talk to AWS
      #
      # == Parameters:
      # config::
      #   A hash of configuration data to verify
      #
      def verify_config config
        if !config.has_key? 'sqs'
          raise RuntimeError, 'missing sqs sender config'
        end
        ['access_key_id', 'secret_access_key', 'region',
         'queue_name'].each do |key|
          if !config['sqs'].has_key? key
            raise RuntimeError, "missing sqs sender config: #{key}"
          end
        end
      end

      # Send an arbitrary text message to the queue for processing
      #
      # == Parameters:
      # msg::
      #   The arbitrary text data to send
      #
      def send msg
        config = Cloudalogue::config
        verify_config config

        sqs = AWS::SQS.new(
          :access_key_id => config['sqs']['access_key_id'],
          :secret_access_key => config['sqs']['secret_access_key'],
          :region => config['sqs']['region']
        )

        queue = sqs.queues.create config['sqs']['queue_name']
        queue.send_message msg
      end

    end
  end
end

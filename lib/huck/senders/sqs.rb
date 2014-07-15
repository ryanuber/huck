module Huck

  module Senders

    # A sender that talks to Amazon Simple Queue Service
    class SQSSender < Sender

      # Includes all required modules for the SQS sender
      def initialize
        Huck::must_load 'aws-sdk'
      end

      # Ensures that configuration is set properly before trying to use the
      # connection data to talk to AWS
      def verify_config
        if !@config.has_key? 'sqs'
          raise RuntimeError, 'missing sqs sender config'
        end
        ['access_key_id', 'secret_access_key', 'region',
         'queue_name'].each do |key|
          if !@config['sqs'].has_key? key
            raise RuntimeError, "missing sqs sender config: #{key}"
          end
        end
      end

      # Send an arbitrary text message to the queue for processing
      #
      # == Parameters:
      # msg::
      #   The message to process
      #
      def send msg
        verify_config

        sqs = AWS::SQS.new(
          :access_key_id => @config['sqs']['access_key_id'],
          :secret_access_key => @config['sqs']['secret_access_key'],
          :region => @config['sqs']['region']
        )

        queue = sqs.queues.create @config['sqs']['queue_name']
        queue.send_message msg
      end

    end
  end
end

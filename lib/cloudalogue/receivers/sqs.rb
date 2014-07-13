module Cloudalogue

  module Receivers

    # A receiver that talks to Amazon Simple Queue Service
    class SQSReceiver < Receiver

      # Includes all required modules for the SQS receiver
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
          raise RuntimeError, 'missing sqs config'
        end
        ['access_key_id', 'secret_access_key', 'region',
         'queue_name'].each do |key|
          if !config['sqs'].has_key? key
            raise RuntimeError, "missing sqs config: #{key}"
          end
        end
      end

      # A long-running poller process which reads messages out of the remote
      # queue and yields them to higher-order logic.
      def receive
        config = Cloudalogue::config
        verify_config config

        sqs = AWS::SQS.new(
          :access_key_id => config['sqs']['access_key_id'],
          :secret_access_key => config['sqs']['secret_access_key'],
          :region => config['sqs']['region']
        )

        queue = sqs.queues.create config['sqs']['queue_name']
        queue.poll do |msg|
          yield msg
        end
      end

    end
  end
end

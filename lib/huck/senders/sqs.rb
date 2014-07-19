module Huck

  module Senders

    # A sender that talks to Amazon Simple Queue Service
    class SQSSender < Sender

      # Includes all required modules for the SQS sender
      def initialize
        Huck::must_load 'aws-sdk'
      end

      # Ensures that configuration is set properly before trying to use the
      # connection data to talk to AWS. It is possible that IAM profiles are
      # in use, so we can't strictly require that all of the access information
      # is set in the configuration.
      def verify_config
        if !@config.has_key? 'sqs'
          raise Huck::Error, 'missing sqs sender config'
        end
        if !@config['sqs'].has_key? 'queue_name'
          raise Huck::Error, 'missing sqs sender config: queue_name'
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

        options = Hash.new
        [:access_key_id, :secret_access_key, :region].each do |arg|
          if @config['sqs'].has_key? arg.to_s
            options[arg] = @config['sqs'][arg.to_s]
          end
        end

        sqs = AWS::SQS.new options

        queue = sqs.queues.create @config['sqs']['queue_name']
        queue.send_message msg
      end

    end
  end
end

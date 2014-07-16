module Huck

  module Senders

    # A sender that talks to RabbitMQ
    class RabbitMQSender < Sender

      # Includes all required modules for the RabbitMQ sender
      def initialize
        Huck::must_load 'bunny'
      end

      # Ensures that configuration is set properly before trying to use the
      # connection data to talk to rabbitmq
      def verify_config
        if !@config.has_key? 'rabbitmq'
          raise RuntimeError, 'missing rabbitmq sender config'
        end
        if !@config['rabbitmq'].has_key? 'queue_name'
          raise RuntimeError, 'missing rabbitmq sender config: queue_name'
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
        [:host, :port, :user, :pass, :vhost].each do |arg|
          if @config['rabbitmq'].has_key? arg.to_s
            options[arg] = @config[arg.to_s]
          end
        end

        conn = Bunny.new options
        conn.start

        ch = conn.create_channel
        queue = ch.queue(@config['rabbitmq']['queue_name'])
        xfer = ch.default_exchange

        xfer.publish msg, :routing_key => @config['rabbitmq']['queue_name']
      end

    end
  end
end

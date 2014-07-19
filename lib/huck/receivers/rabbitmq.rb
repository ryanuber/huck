module Huck

  module Receivers

    # A receiver that talks to RabbitMQ
    class RabbitMQReceiver < Receiver

      # Includes all required modules for the RabbitMQ receiver
      def initialize
        Huck::must_load 'bunny'
      end

      # Ensures that configuration is set properly before trying to use the
      # connection data to talk to RabbitMQ
      def verify_config
        if !@config.has_key? 'rabbitmq'
          raise Huck::Error, 'missing rabbitmq config'
        end
        if !@config['rabbitmq'].has_key? 'queue_name'
          raise Huck::Error, 'missing rabbitmq receiver config: queue_name'
        end
      end

      # A long-running poller process which reads messages out of the remote
      # queue and yields them to higher-order logic.
      def receive
        verify_config

        options = Hash.new
        [:host, :port, :user, :pass, :vhost].each do |arg|
          if @config['rabbitmq'].has_key? arg.to_s
            options[arg] = @config['rabbitmq'][arg.to_s]
          end
        end

        conn = Bunny.new options
        conn.start

        ch = conn.create_channel
        queue = ch.queue(@config['rabbitmq']['queue_name'])

        queue.subscribe :block => true do |_, _, msg|
          yield msg
        end
      end

    end
  end
end

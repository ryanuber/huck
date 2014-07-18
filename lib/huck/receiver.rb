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

      name = 'sqs' if name.nil?

      case name
      when 'sqs'
        r = Receivers::SQSReceiver.new
      when 'rabbitmq'
        r = Receivers::RabbitMQReceiver.new
      else
        raise RuntimeError, "bad receiver: #{name}"
      end

      r.config = config
      return r
    end

    # Given some handlers (or a block), grab messages out of the
    # queue and feed them through to the handlers.
    #
    # == Parameters:
    # handlers::
    #   An array of Huck::Handler instances
    # block::
    #   A code block, or nil
    #
    def accept handlers, block
      begin
        receive do |msg|
          begin
            if block
              hname = '<block>'
              block.call msg
              next # skip other handlers
            end

            handlers.each do |h|
              hname = h.class.to_s
              h.handle msg
            end
          rescue => e
            puts "Handler error (#{hname}): #{e.message}"
          end
        end
      rescue Interrupt, SystemExit
        return
      rescue => e
        puts "Receiver error (#{self.class}): #{e.message}"
        puts "Retrying in 5s..."
        sleep 5
        retry
      end
    end

  end
end

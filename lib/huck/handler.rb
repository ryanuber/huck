module Huck

  # Base handler class
  class Handler
    attr_accessor :config

    # Given a handler's name (or no name), return a new handler instance
    #
    # == Parameters:
    # name::
    #   The name of the handler, or nil to guess
    # config::
    #   A configuration hash
    #
    # == Returns:
    # A Huck::Handler instance
    #
    def self.factory kwargs = {}
      name = Huck::getarg kwargs, :name, nil
      config = Huck::getarg kwargs, :config, nil

      name = 'echo' if name.nil?

      case name
      when 'echo'
        h = Handlers::EchoHandler.new
      when 'exec'
        h = Handlers::ExecHandler.new
      else
        raise Huck::Error, "bad handler: #{name}"
      end

      h.config = config
      return h
    end

  end
end

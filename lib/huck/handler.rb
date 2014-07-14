module Huck

  # Base handler class
  class Handler

    # Given a handler's name (or no name), return a new handler instance
    #
    # == Parameters:
    # name::
    #   The name of the handler, or nil to guess
    #
    # == Returns:
    # A Huck::Handler instance
    #
    def self.factory name
      name = 'exec' if name.nil?

      case name
      when 'exec'
        hand = Handlers::ExecHandler.new
      else
        raise RuntimeError, "bad handler: #{name}"
      end

      return hand
    end

  end
end

module Huck

  module Handlers

    # The most basic handler to echo messages to stdout
    class EchoHandler < Handler

      # Handles a message by printing it
      def handle msg
        puts msg
      end

    end
  end
end

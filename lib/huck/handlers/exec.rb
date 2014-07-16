module Huck

  module Handlers

    # A handler to execute arbitrary scripts, passing in the generated text as
    # input on stdin.
    class ExecHandler < Handler

      # Includes all required modules
      def initialize
        Huck::must_load 'open3'
      end

      # Ensures that configuration is set properly before executing
      def verify_config
        if !@config.has_key? 'command'
          raise RuntimeError, 'missing "exec" generator config: "command"'
        end
      end

      # Handle an individual message by running an executable, passing in the
      # gathered data via stdin.
      #
      # == Parameters:
      # msg::
      #   The message to process
      #
      def handle msg
        verify_config

        Open3.popen2 @config['command'] do |stdin, _, _|
          stdin.print msg
        end
      end

    end
  end
end

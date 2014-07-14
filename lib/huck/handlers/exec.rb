module Huck

  module Handlers

    # A handler to execute arbitrary scripts, passing in the generated text as
    # input on stdin.
    class ExecHandler < Handler

      def initialize
        require 'open3'
      end

      # Ensures that configuration is set properly before executing
      #
      # == Parameters:
      # config::
      #   A hash of configuration data to verify
      #
      def verify_config config
        if !config.has_key? 'exec'
          raise RuntimeError, 'missing exec config'
        end
        if !config['exec'].has_key? 'command'
          raise RuntimeError, 'missing exec config: command'
        end
      end

      # Handle an individual message by running an executable, passing in the
      # gathered data via stdin.
      def handle msg
        config = Huck::config
        verify_config config

        Open3.popen2 config['exec']['command'] do |stdin, stdout, thread|
          stdin.print msg
        end
      end

    end
  end
end

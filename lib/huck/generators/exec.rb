module Huck

  module Generators

    # A generator to execute arbitrary scripts and use their output
    class ExecGenerator < Generator

      # Includes all required modules
      def initialize
        Huck::must_load 'open3'
      end

      # Ensures that configuration is set properly before executing
      def verify_config
        if !@config.has_key? 'command'
          raise Huck::Error, 'missing "exec" generator config: "command"'
        end
      end

      # Generate data by running a command and collecting output
      def generate
        verify_config

        Open3.popen2e @config['command'] do |_, output, thread|
          thread.value # wait for process to complete
          return output.read
        end
      end

    end
  end
end

module Huck

  module Generators

    # File generator reads any file and submits the raw content
    class FileGenerator < Generator

      # Ensure that all JSON config items are properly set
      def verify_config
        if !@config.has_key? 'path'
          raise RuntimeError, 'missing "file" generator config: "path"'
        end
      end

      # Reads in a configured file and returns the data
      #
      # == Returns:
      # The text contained within the specified file
      #
      def generate
        verify_config
        IO.read(@config['path'])
      end

    end
  end
end

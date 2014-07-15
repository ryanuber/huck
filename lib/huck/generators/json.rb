module Huck

  module Generators

    # JSON generator reads json files for data
    class JsonGenerator < Generator

      # Load required modules for json generator
      def initialize
        Huck::must_load 'json'
      end

      # Ensure that all JSON config items are properly set
      def verify_config
        if !@config.has_key? 'json'
          raise RuntimeError, 'missing json config'
        end
        if !@config['json'].has_key? 'file'
          raise RuntimeError, 'missing json config: file'
        end
      end

      # Reads in a configured JSON file and returns the data
      #
      # == Returns:
      # A hash of facts read from the JSON file
      #
      def generate
        verify_config
        JSON.load IO.read(@config['json']['file'])
      end

    end
  end
end

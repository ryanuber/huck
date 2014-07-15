module Huck

  module Generators

    # YAML generator reads yaml files for data
    class YamlGenerator < Generator

      # Load required modules for yaml generator
      def initialize
        Huck::must_load 'yaml'
      end

      # Ensure that all YAML config items are properly set
      def verify_config
        if !@config.has_key? 'yaml'
          raise RuntimeError, 'missing yaml config'
        end
        if !@config['yaml'].has_key? 'file'
          raise RuntimeError, 'missing yaml config: file'
        end
      end

      # Reads in a configured YAML file and returns the data
      #
      # == Returns:
      # A hash of facts read from the YAML file
      #
      def generate
        verify_config
        YAML.load_file @config['yaml']['file']
      end

    end
  end
end

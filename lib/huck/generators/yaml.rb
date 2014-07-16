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
        if !@config.has_key? 'path'
          raise RuntimeError, 'missing "yaml" generator config: "path"'
        end
      end

      # Reads in a configured YAML file and returns the data
      #
      # == Returns:
      # A hash of facts read from the YAML file
      #
      def generate
        verify_config
        YAML.load_file @config['path']
      end

    end
  end
end

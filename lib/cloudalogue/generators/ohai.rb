module Cloudalogue

  module Generators

    # Ohai provider for generating consumeable data
    class OhaiGenerator < Generator

      # Load required modules for ohai generator
      def initialize
        require 'ohai/system'
      end

      # This method generates the data and returns it as a hash
      #
      # == Returns
      # A hash of hints as returned by ohai
      def generate
        ohai = Ohai::System.new
        ohai.all_plugins

        # Need to load the JSON output, since ohai emits a 'mash' object map
        # instead of normal hashes, making serialization ugly in some cases
        # like YAML where canonical objects (eg. !ruby/mash) is emitted.
        JSON.load ohai.json_pretty_print
      end

    end
  end
end

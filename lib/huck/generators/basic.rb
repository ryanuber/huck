module Huck

  module Generators

    # A very basic host info generator
    class BasicGenerator < Generator

      # Include required modules
      def initialize
        require 'socket'
      end

      # Reads in a configured JSON file and returns the data
      #
      # == Returns:
      # A hash of facts read from the JSON file
      def generate
        {'hostname' => Socket.gethostname,
         'platform' => RUBY_PLATFORM}
      end

    end
  end
end

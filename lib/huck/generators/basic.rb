module Huck

  module Generators

    # A very basic host info generator
    class BasicGenerator < Generator

      # Include required modules
      def initialize
        Huck::must_load 'socket'
      end

      # Generates bare minimum useful information
      #
      # == Returns:
      # A hash of host information
      #
      def generate
        data = {'hostname' => Socket.gethostname,
                'platform' => RUBY_PLATFORM}
        Huck::serialize data, :format => @config['format']
      end

    end
  end
end

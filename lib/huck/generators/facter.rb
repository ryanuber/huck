module Huck

  module Generators

    # Facter provider for generating consumeable data
    class FacterGenerator < Generator

      # Load required modules for facter generator
      def initialize
        Huck::must_load 'facter'
      end

      # Generate data using facter
      #
      # == Returns:
      # A hash of facts as returned by facter
      #
      def generate
        Facter.to_hash
      end

    end
  end
end

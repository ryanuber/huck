module Cloudalogue

  # Facter provider for generating consumeable data
  class FacterGenerator < Generator

    # Load required modules for facter generator
    def initialize
      if !Cloudalogue::try_load 'facter'
        raise RuntimeError, 'unable to load facter'
      end
    end

    # This method generates the data and returns it as a hash
    #
    # == Returns
    # A hash of facts as returned by facter
    def generate
      Facter.to_hash
    end

  end
end

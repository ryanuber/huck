require 'facter'

module Cloudalogue

  # Facter provider for generating consumeable data
  class FacterGenerator < Generator

    # This method generates the data and returns it as a hash
    #
    # == Returns
    # A hash of facts as returned by facter
    def generate
      Facter.to_hash
    end

  end
end

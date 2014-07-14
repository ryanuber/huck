module Cloudalogue

  class Generator

    # This method will call the generation method, and return the data in the
    # desired format.
    def dump kwargs = {}
      format = Cloudalogue::getarg kwargs, :format, 'json'
      data = generate
      if !data.is_a? Hash
        raise RuntimeError, 'cannot handle non-hash data'
      end

      case format
      when 'json'
        return JSON.dump data
      when 'yaml'
        return YAML.dump data
      else
        raise RuntimeError, "unknown format '#{format}'"
      end
    end

    # Given a generator's name (or no name), return a new generator instance
    #
    # == Parameters:
    # name::
    #   The name of the generator, or empty/nil to guess
    #
    # == Returns:
    # A Cloudalogue::Generator instance
    #
    def self.factory name
      if name.nil?
        if Cloudalogue::try_load 'facter'
          name = 'facter'
        elsif Cloudalogue::try_load 'ohai'
          name = 'ohai'
        else
          raise RuntimeError, 'unable to load any generators'
        end
      end

      case name
      when 'facter'
        gen = Generators::FacterGenerator.new
      when 'ohai'
        gen = Generators::OhaiGenerator.new
      else
        raise RuntimeError, "bad generator: #{name}"
      end

      return gen
    end

  end
end

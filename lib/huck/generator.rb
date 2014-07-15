module Huck

  class Generator

    attr_accessor :config

    # This method will call the generation method, and return the data in the
    # desired format.
    def dump kwargs = {}
      format = Huck::getarg kwargs, :format, 'json'
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
    # config::
    #   A configuration hash
    #
    # == Returns:
    # A Huck::Generator instance
    #
    def self.factory kwargs = {}
      name = Huck::getarg kwargs, :name, nil
      config = Huck::getarg kwargs, :config, nil

      if name.nil?
        if Huck::try_load 'facter'
          name = 'facter'
        elsif Huck::try_load 'ohai'
          name = 'ohai'
        else
          raise RuntimeError, 'unable to load any generators'
        end
      end

      case name
      when 'facter'
        g = Generators::FacterGenerator.new
      when 'ohai'
        g = Generators::OhaiGenerator.new
      else
        raise RuntimeError, "bad generator: #{name}"
      end

      g.config = config
      return g
    end

  end
end

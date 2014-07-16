module Huck

  class Generator

    attr_accessor :config

    # Given a generator's name (or no name), return a new generator instance
    #
    # == Parameters:
    # name::
    #   The name of the generator
    # config::
    #   A configuration hash
    #
    # == Returns:
    # A Huck::Generator instance
    #
    def self.factory kwargs = {}
      name = Huck::getarg kwargs, :name, nil
      config = Huck::getarg kwargs, :config, nil

      name = 'basic' if name.nil?

      case name
      when 'basic'
        g = Generators::BasicGenerator.new
      when 'facter'
        g = Generators::FacterGenerator.new
      when 'ohai'
        g = Generators::OhaiGenerator.new
      when 'file'
        g = Generators::FileGenerator.new
      when 'yaml'
        g = Generators::YamlGenerator.new
      when 'json'
        g = Generators::JsonGenerator.new
      else
        raise RuntimeError, "bad generator: #{name}"
      end

      g.config = config
      return g
    end

  end
end

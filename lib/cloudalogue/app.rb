module Cloudalogue

  # App is the main class which controls the running program.
  class App

    def self.run kwargs = {}
      gen_name = Cloudalogue::getarg kwargs, :generator, nil
      g = self.generator_factory gen_name
      g.dump
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
    def self.generator_factory name
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
        gen = FacterGenerator.new
      when 'ohai'
        gen = OhaiGenerator.new
      end

      if !defined? gen
        raise RuntimeError, "bad generator: #{name}"
      end

      return gen
    end

  end
end

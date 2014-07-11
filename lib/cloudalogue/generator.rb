require 'json'
require 'yaml'

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

  end
end

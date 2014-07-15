module Huck

  # Retrieve the value of an "emulated" kwarg easily
  #
  # == Parameters:
  # args::
  #   A hash of kwargs
  # arg::
  #   The name of the arg desired
  # default::
  #   If arg does not exist in args, return this
  #
  # == Returns:
  # The value of the arg, or the default value
  #
  def self.getarg args, arg, default
    return args.has_key?(arg) ? args[arg] : default
  end

  # Read configuration out of a file on the filesystem.
  #
  # == Parameters:
  # path::
  #   The path to the config file to read
  #
  # == Returns:
  # A hash containing the configuration
  #
  def self.config kwargs = {}
    path = self.getarg kwargs, :path, nil
    path = File.join(Dir.home, 'huck.conf') if path.nil?
    YAML.load_file path
  end

  # Attempts to load a given module by name
  #
  # == Parameters:
  # name::
  #   The name of the module
  #
  # == Returns:
  # bool
  #
  def self.try_load name
    begin
      require name
    rescue LoadError
      return false
    end
    true
  end

  # Try to load a module, and raise a RuntimeError if it is not
  # loadable. This is useful for trying to load certain provider
  # code at runtime without dealing with LoadError.
  #
  # == Parameters:
  # name::
  #   The name of the module
  #
  def self.must_load name
    if !self.try_load name
      raise RuntimeError, "unable to load #{name}"
    end
  end

  # Serialize a hash to a desired format.
  #
  # == Parameters:
  # format::
  #   The serialization format (json or yaml)
  #
  # == Returns:
  # A string of serialized text
  #
  def self.serialize_hash data, kwargs = {}
    format = Huck::getarg kwargs, :format, 'json'
    if !data.is_a? Hash
      raise RuntimeError, 'cannot serialize non-hash data'
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

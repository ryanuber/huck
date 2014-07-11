require 'yaml'

module Cloudalogue

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
    path = self.getarg kwargs, 'path', '/etc/cloudalogue.yaml'
    YAML.load_file path
  end

end

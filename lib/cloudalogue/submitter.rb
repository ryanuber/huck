module Cloudalogue

  # The base submitter class
  class Submitter

    # Given a submitter's name (or no name), return a new submitter instance
    #
    # == Parameters:
    # name::
    #   The name of the submitter, or nil to guess
    #
    # == Returns:
    # A Cloudalogue::Submitter instance
    #
    def self.factory name
      if name.nil?
        if Cloudalogue::try_load 'aws-sdk'
          name = 'sqs'
        else
          raise RuntimeError, 'unable to load any submitters'
        end
      end

      case name
      when 'sqs'
        subm = Submitters::SQSSubmitter.new
      else
        raise RuntimeError, "bad submitter: #{name}"
      end

      return subm
    end

  end
end

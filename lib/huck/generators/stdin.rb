module Huck

  module Generators

    # A generator to use from the command line by piping in text
    class StdinGenerator < Generator
      attr_accessor :stdin
      @stdin = STDIN

      # Submit all data from stdin.
      def generate
        data = ''

        # Try reading 1 byte first in non-blocking mode. If the call would block
        # during read(), then we just bail and raise. Otherwise, if at least 1
        # byte can be read, we proceed to read until EOF since we already have
        # our stream of data.
        begin
          data += @stdin.read_nonblock 1
        rescue Errno::EWOULDBLOCK
          raise Huck::Error, 'no data from stdin'
        end
        data += @stdin.read
        data
      end

    end
  end
end

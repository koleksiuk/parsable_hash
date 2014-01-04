module ParsableHash
  module Converters
    class Null < Base
      private

      def try_convert
        @value
      end
    end
  end
end

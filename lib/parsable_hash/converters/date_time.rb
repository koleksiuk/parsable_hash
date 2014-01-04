module ParsableHash
  module Converters
    class DateTime < Base
      private

      def try_convert
        ::DateTime.parse(@value)
      end
    end
  end
end

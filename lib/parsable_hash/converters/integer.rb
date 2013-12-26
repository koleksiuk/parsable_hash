module ParsableHash
  module Converters
    class Integer < Base
      private

      def try_convert
        @value.to_i
      end
    end
  end
end

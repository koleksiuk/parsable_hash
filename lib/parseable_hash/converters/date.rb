module ParseableHash
  module Converters
    class Date < Base
      private

      def try_convert
        ::Date.parse(@value)
      end
    end
  end
end

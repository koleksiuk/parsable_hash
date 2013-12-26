module ParseableHash
  module Converters
    class Boolean < Base
      private

      def try_convert
        @value.to_s == "true"
      end
    end
  end
end

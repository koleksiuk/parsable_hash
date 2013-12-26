module ParsableHash
  module Converters
    class Float < Base
      private

      def try_convert
        @value.to_f
      end
    end
  end
end

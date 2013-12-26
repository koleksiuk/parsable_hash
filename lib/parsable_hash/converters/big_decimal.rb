require 'bigdecimal'

module ParsableHash
  module Converters
    class BigDecimal < Base
      private

      def try_convert
        ::BigDecimal.new(@value)
      end
    end
  end
end

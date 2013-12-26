require 'date' if RUBY_VERSION < '1.9.3'

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

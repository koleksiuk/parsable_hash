module ParseableHash
  module Converters
    class Base
      def initialize(value)
        @value = value
      end

      def call(&block)
        try_convert
      rescue => e
        if block_given?
          block.call(@value)
        else
          @value
        end
      end

      protected

      def try_convert
        raise NotImplementedError.new
      end
    end
  end
end

Gem.find_files("parseable_hash/converters/*.rb").delete_if {|f| f =~ /base/ }.each {|f| require f }

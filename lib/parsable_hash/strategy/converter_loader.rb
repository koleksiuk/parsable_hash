module ParsableHash
  module Strategy
    class ConverterLoader
      def self.from_value(value)
        if value.is_a? Class
          from_class(value)
        else
          from_name(value)
        end
      end

      def self.from_name(name)
        new(name)
      end

      def self.from_class(klass)
        new(nil, :converter => klass)
      end

      attr_accessor :klass

      def initialize(name, options = {})
        @name      = name.to_s
        self.klass = options.fetch(:converter) { load_from_name }
      end

      def call(val)
        klass.new(val).call
      end

      private

      def load_from_name
        ParsableHash::Converters.const_get(camelize(@name))
      rescue
        ParsableHash::Converters::Null
      end

      def camelize(name)
        name.split('_').map(&:capitalize).join
      end
    end
  end
end

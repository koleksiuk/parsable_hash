module ParseableHash
  module Strategy
    class ConverterLoader
      def self.from_name(name)
        new(name)
      end

      def self.from_class(klass)
        new(nil, :converter => klass)
      end

      attr_accessor :klass

      def initialize(name, options = {})
        @name      = name
        self.klass = options.fetch(:converter) { load_from_name }
      end

      def call(val)
        klass.new(val).call
      end

      private

      def load_from_name
        ParseableHash::Converters.const_get(camelize(@name))
      end

      def camelize(name)
        name.to_s.split('_').map(&:capitalize).join
      end
    end
  end
end

module ParseableHash
  MissingStrategy = Class.new(StandardError)

  class Strategies
    class << self
      def fallbacks
        @fallbacks.nil? ? true : @fallbacks
      end

      attr_writer :fallbacks
    end

    def initialize(value = {})
      strategies[:default] = value
    end

    def [](strategy)
      get(strategy)
    end

    def []=(strategy, value)
      add(strategy, value)
    end

    def get(strategy)
      _strategy = strategies[strategy.to_sym]

      return _strategy           unless _strategy.nil?
      return strategies[:default] if _strategy.nil? && self.class.fallbacks

      raise MissingStrategy.new("Strategy #{strategy} is missing!")
    end

    def add(strategy, value)
      strategies[strategy] = value
    end

    private

    def strategies
      @strategies ||= {}
    end
  end
end

module ParsableHash
  class Parser
    def initialize(hash, strategy)
      @hash     = hash
      @strategy = HashStrategy.new(strategy, @hash)
    end

    def call
      deep_parse(@hash, @strategy.hash)
    end

    private
    def deep_parse(hash, strategy)
      hash.merge(strategy) do |key, val, str|
        if val.is_a?(Hash) && str.is_a?(Hash)
          deep_parse(val, str)
        else
          parse_with_strategy(val, str)
        end
      end
    end

    def parse_with_strategy(value, strategy)
      strategy.call(value)
    end
  end
end

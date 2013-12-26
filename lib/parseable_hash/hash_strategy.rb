module ParseableHash
  class HashStrategy
    def initialize(strategy)
      @strategy = prepare(strategy)
    end

    attr_reader :strategy

    private

    def prepare(hash)
      hash.inject({}) do |hash, (k, v)|
        if v.is_a?(Hash)
          hash[k] = prepare(v)
        else
          hash[k] = Strategy::ConverterLoader.from_value(v)
        end

        hash
      end
    end
  end
end

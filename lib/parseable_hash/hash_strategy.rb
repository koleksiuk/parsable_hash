module ParseableHash
  class HashStrategy
    def initialize(strategy)
      @strategy = prepare(strategy)
    end

    private

    def prepare(hash)
      hash.map do |k, v|
        if v.is_a? Hash
          k = prepare(v)
        else
          k =  Strategy::TypeLoader.new(v)
        end
      end
    end
  end
end

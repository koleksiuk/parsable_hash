module ParsableHash
  class HashStrategy
    include Enumerable

    attr_reader   :hash
    attr_accessor :origin_hash

    def initialize(strategy, origin_hash = nil)
      @hash = prepare(strategy)
      self.origin_hash = origin_hash

      clean_for_hash!(origin_hash) unless origin_hash.nil?
    end

    def each(&block)
      hash.each { |strategy| yield strategy }
    end

    def clean_for_hash!(value_hash)
      @hash = clean_pairs(@hash, value_hash)
    end

    private

    def prepare(hash)
      hash.inject({}) do |h, (k, v)|
        h[k] = if v.is_a? Hash
                    prepare(v)
                  else
                    Strategy::ConverterLoader.from_value(v)
                  end

        h
      end
    end

    def clean_pairs(strategy_hash, value_hash)
      strategy_hash.each_pair do |key, val|
        if value_hash[key].is_a?(Hash)
          if val.is_a?(Hash)
            clean_pairs(strategy_hash[key], value_hash[key])
          else
            strategy_hash.delete(key)
          end
        else
          strategy_hash.delete(key) unless value_hash.has_key?(key)
        end
      end
    end
  end
end

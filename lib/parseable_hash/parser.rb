module ParseableHash
  class Parser
    def initialize(hash, strategy)
      @hash     = hash
      @strategy = strategy
    end

    def call
      @hash
    end

    private
  end
end

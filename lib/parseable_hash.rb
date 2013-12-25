require "parseable_hash/version"

module ParseableHash
  def self.included(klass)
    klass.send(:include, InstanceMethods)
    klass.extend(ClassMethods)
  end

  module InstanceMethods
    def parse_hash(object, options = {})
      parse_with_strategy(object, options[:with])
    end

    private

    def parse_with_strategy(hash, strategry = :default)
      hash
    end
  end

  module ClassMethods
    def parse_strategy(name, options = {})
      parse_strategies[name] = options
    end

    def parse_strategies
      @parse_strategies ||= {}
    end
  end
end

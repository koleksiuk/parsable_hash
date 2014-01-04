require 'parsable_hash/version'
require 'parsable_hash/strategies'
require 'parsable_hash/converters/base'
require 'parsable_hash/strategy/converter_loader'
require 'parsable_hash/hash_strategy'
require 'parsable_hash/parser'

require 'parsable_hash/core_ext/hash/parse_with'

module ParsableHash
  NotDefinedError = Class.new(StandardError)

  def self.included(klass)
    klass.send(:include, InstanceMethods)
    klass.extend(ClassMethods)
  end

  module InstanceMethods
    def parse_hash(object, options = {})
      parse_with_strategy(object, options[:with], options[:const])
    end

    private

    def parse_with_strategy(hash, strategy, const = nil)
      if const && const.is_a?(Module)
        raise NotDefinedError.new unless const.include?(ParsableHash)

        Parser.new(hash, const.parse_strategies[strategy]).call
      else
        Parser.new(hash, parse_strategies[strategy]).call
      end
    end

    def parse_strategies
      self.class.parse_strategies
    end
  end

  module ClassMethods
    def parse_strategy(name, options = {})
      parse_strategies.add(name, options)
    end

    def parse_strategies
      @strategies ||= Strategies.new
    end
  end
end

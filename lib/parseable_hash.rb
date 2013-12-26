require 'pry'
require 'parseable_hash/version'
require 'parseable_hash/parser'
require 'parseable_hash/strategies'

require 'parseable_hash/converters/base'
Gem.find_files("parseable_hash/converters/*.rb").delete_if {|f| f =~ /base/ }.each {|f| require f }

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

    def parse_with_strategy(hash, strategy)
      Parser.new(hash, parse_strategies[strategy]).call
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

require 'spec_helper'

class OwnParser
  def self.parse(value)
    "foo#{value}"
  end
end

module ParsableHash
  module Converters
    class OwnParser < Base
      private

      def try_convert
        ::OwnParser.parse(@value)
      end
    end
  end
end

class DummyExt
  include ParsableHash

  parse_strategy :dummy, :str => :own_parser

  def initialize(options = {})
    @options = options
  end

  def call
    parse_hash(@options, :with => :dummy)
  end
end

describe 'DummyExtension' do
  describe 'call' do
    it 'should return string with prepended foo' do
      obj = DummyExt.new(:str => 'bar')

      expect(obj.call).to eq({ :str => 'foobar' })
    end
  end
end

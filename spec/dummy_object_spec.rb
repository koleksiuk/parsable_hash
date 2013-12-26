require 'spec_helper'

class Dummy
  include ParseableHash

  parse_strategy :random_values, int: :integer, fl: :float, nested: { dt: :date }
  parse_strategy :int, int: :integer

  def initialize(options = {})
    @options = options
  end

  def call
    parse_hash(@options, with: :random_values)
  end
end

describe Dummy do
  context 'when all values exist' do
    let(:str_date) { '12.12.2013' }
    let(:obj_date) { Date.parse(str_date) }
    let(:obj) { Dummy.new(int: '3', fl: '3.5', nested: { dt: str_date }) }

    let(:parsed_hash) { obj.call }

    it 'should parse hash to values passed with given strategy' do
      expect(parsed_hash).to eq(int: 3, fl: 3.5, nested: { dt: obj_date })
    end
  end
end

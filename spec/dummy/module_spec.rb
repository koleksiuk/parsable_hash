require 'spec_helper'

class Dummy
  include ParsableHash

  parse_strategy :random_values, :int => :integer, :fl => :float, :nested => { :dt => :date }
  parse_strategy :int, :int => :integer

  def initialize(options = {})
    @options = options
  end

  def call
    parse_hash(@options, :with => :random_values)
  end
end

describe Dummy do
  context 'when all values exist' do
    let(:str_date) { '12.12.2013' }
    let(:obj_date) { Date.parse(str_date) }
    let(:obj) { Dummy.new(:int => '3', :fl => '3.5', :nested => { :dt => str_date }) }

    let(:parsed_obj_with_hash) { obj.call }

    it 'should parse hash to values passed with given strategy' do
      expect(parsed_obj_with_hash).to eq({
        :int    => 3,
        :fl     => 3.5,
        :nested => { :dt => obj_date },
      })
    end
  end

  context 'when hash value is missing' do
    let(:obj) { Dummy.new(:int => '3', :nested => { :foo => 'test' }, :bar => { :test => 'foobar' }) }

    let(:parsed_obj_with_hash) { obj.call }
    it 'should not create new key-value pair in hash' do
      expect(parsed_obj_with_hash).to eq({
        :int    => 3,
        :nested => { :foo  => 'test'   },
        :bar    => { :test => 'foobar' },
      })
    end
  end
end


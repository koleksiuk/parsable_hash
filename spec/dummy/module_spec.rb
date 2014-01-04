require 'spec_helper'

module DummyParsers
  include ParsableHash

  parse_strategy :rands, :int => :integer, :fl => :float, :nested => { :dt => :date }
end

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

  def call_with_const
    parse_hash(@options, :with => :rands, :const => DummyParsers)
  end

  def call_with_wrong_const
    parse_hash(@options, :with => :rands, :const => Object)
  end

  def direct_call
    @options.parse_with(self, :random_values)
  end

  def const_call
    @options.parse_with(DummyParsers, :rands)
  end
end

describe Dummy do
  describe '#parse_hash' do
    context 'when all values exist' do
      let(:obj) { Dummy.new(:int => '3', :fl => '3.5', :nested => { :dt => str_date }) }
      let(:str_date) { '12.12.2013' }
      let(:obj_date) { Date.parse(str_date) }

      after do
        expect(parsed_obj_with_hash).to eq({
          :int    => 3,
          :fl     => 3.5,
          :nested => { :dt => obj_date },
        })
      end

      describe 'call' do
        let(:parsed_obj_with_hash) { obj.call }

        it 'should parse hash to values passed with given strategy' do
        end
      end

      describe 'call with constant passed' do
        let(:parsed_obj_with_hash) { obj.call_with_const }

        it 'should parse hash to values passed with given strategy' do
        end
      end

    end

    describe 'call with wrong constant passed' do
      let(:obj) { Dummy.new }

      it 'should raise an error' do
        expect {
          obj.call_with_wrong_const
        }.to raise_error(ParsableHash::NotDefinedError)
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

  describe 'hash#parse_with' do
    let(:str_date) { '12.12.2013' }
    let(:obj_date) { Date.parse(str_date) }
    let(:obj) { Dummy.new(:int => '3', :fl => '3.5', :nested => { :dt => str_date }) }

    after do
      expect(subject).to eq({
        :int    => 3,
        :fl     => 3.5,
        :nested => { :dt => obj_date },
      })
    end

    context 'with self' do
      subject { obj.direct_call }
      it 'should parse hash to values passed with given strategy' do
      end
    end

    context 'with class / module' do
      subject { obj.const_call }
      it 'should parse hash to values passed with given strategy' do
      end
    end
  end
end


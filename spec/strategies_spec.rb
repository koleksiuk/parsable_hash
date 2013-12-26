require 'spec_helper'

describe ParsableHash::Strategies do
  let(:strategies)    { described_class.new }
  let(:foo_strategy)  { { :bar => :integer } }

  describe 'on initialize' do
    it 'should have at least default strategy' do
      expect(strategies[:default]).to eq({})
    end
  end

  describe 'accessing strategry' do

    before { strategies.add(:new, foo_strategy) }

    it 'should return strategy with array accessor' do
      expect(strategies[:new]).to eq(foo_strategy)
    end

    describe '#get' do
      context 'for string' do
        it 'should return strategy' do
          expect(strategies.get('new')).to eq(foo_strategy)
        end
      end

      context 'for symbol' do
        it 'should return strategy' do
          expect(strategies.get(:new)).to eq(foo_strategy)
        end
      end
    end
  end

  describe 'setting strategy' do
    it 'should allow to set strategy with array accessor' do
      strategies[:new] = foo_strategy
      expect(strategies.get(:new)).to eq(foo_strategy)
    end

    it 'should allow to set strategy with #add method' do
      strategies.add(:new, foo_strategy)
      expect(strategies.get(:new)).to eq(foo_strategy)
    end
  end


  describe 'dealing with missing strategies' do
    context 'by default' do
      it 'should return default strategy' do
        expect(strategies[:foobar]).to eq({})
      end
    end

    context 'when set fallbacks to false' do
      before { ParsableHash::Strategies.fallbacks = false }
      after  { ParsableHash::Strategies.fallbacks = true }

      it 'should raise an error' do
        expect { 
          strategies[:foobar]
        }.to raise_error(ParsableHash::MissingStrategy, "Strategy foobar is missing!")
      end
    end
  end
end

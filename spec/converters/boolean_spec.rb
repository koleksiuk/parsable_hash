require 'spec_helper'

describe ParseableHash::Converters::Boolean do
  describe '#call' do
    describe 'when value == "true"' do
      subject { described_class.new('true') }

      it 'should return true value' do
        expect(subject.call).to eq(true)
      end
    end

    describe 'when value != "true"' do
      subject { described_class.new('falsy') }

      it 'should return false value' do
        expect(subject.call).to eq(false)
      end
    end
  end
end

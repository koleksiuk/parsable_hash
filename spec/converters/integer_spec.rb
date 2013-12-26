require 'spec_helper'

describe ParseableHash::Converters::Integer do
  describe '#call' do
    context 'when value can be parsed' do
      subject { described_class.new('5') }

      it 'should return integer object' do
        expect(subject.call).to eq(5)
      end
    end

    it_should_behave_like "with fallback"
  end
end

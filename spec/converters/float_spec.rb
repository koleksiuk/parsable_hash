require 'spec_helper'

describe ParseableHash::Converters::Float do
  describe '#call' do
    context 'when value can be parsed' do
      subject { described_class.new('5.3') }

      it 'should return integer value' do
        expect(subject.call).to eq(5.3)
      end
    end

    it_should_behave_like "with fallback"
  end
end

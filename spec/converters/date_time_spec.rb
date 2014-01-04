require 'spec_helper'

describe ParsableHash::Converters::DateTime do
  describe '#call' do
    context 'when value can be parsed' do
      let(:date_str) { '12.12.2012' }
      let(:date_obj) { DateTime.parse(date_str) }

      subject { described_class.new('12.12.2012') }

      it 'should return date object' do
        expect(subject.call).to eq(date_obj)
      end
    end

    it_should_behave_like "with fallback"
  end
end

require 'spec_helper'

describe ParsableHash::Converters::Null do
  describe '#call' do
    [3, 'test', Object.new, {}].each do |obj|
      it "should return passed object (e.g. #{obj.class}) without any change" do
        converter = described_class.new(obj)

        expect(converter.call).to eq(obj)
      end
    end
  end
end

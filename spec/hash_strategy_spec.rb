require 'spec_helper'

describe ParseableHash::HashStrategy do

  let(:integer_klass) { double('integer_klass') }
  let(:float_klass)   { double('float_klass')   }
  let(:object_klass)  { double('object_klass') }

  context 'when all values are symbols' do
    before do
      ParseableHash::Strategy::ConverterLoader.stub(:from_name).with(:integer) { integer_klass }
      ParseableHash::Strategy::ConverterLoader.stub(:from_name).with(:float)   { float_klass }
    end

    subject { described_class.new(:one => :integer, :two => :float) }

    it 'should replace them with callable converters' do
      expect(subject.strategy).to eq({
        :one => integer_klass,
        :two => float_klass,
      })
    end
  end

  context 'when there are direct class passed' do
    before do
      ParseableHash::Strategy::ConverterLoader.stub(:from_name).with(:integer) { integer_klass }
      ParseableHash::Strategy::ConverterLoader.stub(:from_class).with(Object)  { object_klass  }
    end

    subject { described_class.new(:one => :integer, :two => Object) }

    it 'should leave them as they are' do
      expect(subject.strategy).to eq({
        :one => integer_klass,
        :two => object_klass,
      })
    end
  end
end

require 'spec_helper'

describe ParsableHash::Strategy::ConverterLoader do
  let(:klass) { double('my_converter') }

  before do
    ParsableHash::Converters.stub(:const_defined?).with('MyConverter') { true }
    ParsableHash::Converters.stub(:const_get).with('MyConverter')      { klass }
  end

  describe 'coverter loading' do
    subject { described_class.new(:my_converter) }

    it 'should load converter class from name' do
      expect(subject.klass).to eq(klass)
    end
  end

  describe 'calling converter' do
    before do
      klass.stub(:new).with('my_val').and_return(inst = double('converter_inst', :call => :my_val))
    end

    it 'should allow to load converter by passed symbol' do
      expect(described_class.new(:my_converter).call('my_val')).to eq(:my_val)
    end
  end


  it 'should allow to initialize loader with given converter' do
    expect(described_class.from_class(klass).klass).to eq(klass)
  end
end

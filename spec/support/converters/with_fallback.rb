shared_examples "with fallback" do
  context 'when value can not be parsed' do
    subject { described_class.new([1,2]) }

    describe 'and block is given' do
      it 'should return value of called block' do
        expect(subject.call {|x| x.count }).to eq(2)
      end
    end

    describe 'and block is missing' do
      it 'should return unchanged value' do
        expect(subject.call).to eq([1,2])
      end
    end
  end
end

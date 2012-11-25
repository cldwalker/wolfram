require File.expand_path('../test_helper', __FILE__)

module Wolfram
  describe 'HashPresenter' do
    before do
      mock(Query).fetch(anything) { read_fixture('boston') }
      @result = Wolfram.fetch('boston')
      @presenter = HashPresenter.new(@result)
    end

    it 'has #result reader' do
      @presenter.result.should == @result
    end

    it 'raises errors for methods that cannot handle' do
      lambda { @presenter.asdasd }.should.raise(NoMethodError)
    end

    it 'delegates #pods to #result' do
      mock(@result).pods
      @presenter.pods
    end

    it 'delegates #assumptions to #result' do
      mock(@result).assumptions
      @presenter.assumptions
    end

    describe '#to_hash' do
      before { @to_hash = @presenter.to_hash }

      it 'returns a hash' do
        Hash.should === @to_hash
      end

      it 'has :pods and :assumptions as keys' do
        (@to_hash.keys - [:pods, :assumptions]).should == []
      end

      it 'includes expected data' do
        @to_hash[:pods]['Populations'].first.should =~ /city population | 617594 people/
        @to_hash[:assumptions]['Clash'].first.should == 'a city'
      end
    end
  end
end

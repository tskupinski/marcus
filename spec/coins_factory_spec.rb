require 'coins_factory'
require 'unsupported_coin'

RSpec.describe CoinsFactory do
  describe '.build' do
    context 'provided valid denomination' do
      it 'creates new coin' do
        result = CoinsFactory.build('1p')

        expect(result).to be_kind_of(Coin)
        expect(result.denomination).to eq('1p')
      end

      it 'calculates value of coin' do
        result = CoinsFactory.build('1p')

        expect(result.value).to eq(1)
      end
    end

    context 'without valid denomination' do
      it 'raises an error' do
        expect { CoinsFactory.build('invalid_denomination') }.to(raise_error(UnsupportedCoinError))
      end
    end
  end
end

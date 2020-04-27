require 'treasury'

RSpec.describe Treasury do
  subject(:treasury) { described_class.new }
  describe '#restock_coins' do
    context 'when the coin of given denomination is in the treasury' do
      before { subject.coins = [Coin.new('1p', 1, 10)] }

      it 'increases coin quantity in the treasury' do
        treasury.restock_coins('1p', 10)

        expect(treasury.coins.count).to eq(1)
        expect(treasury.coins[0].denomination).to eq('1p')
        expect(treasury.coins[0].value).to eq(1)
        expect(treasury.coins[0].quantity).to eq(20)
      end
    end

    context 'when there is no coin of given denomination in the treasury' do
      before { subject.coins = [] }
      
      it 'raises an error' do
        expect{ treasury.restock_coins('invalid_denomination', 10) }.to(raise_error(UnsupportedCoinError))
      end
    end
  end
end

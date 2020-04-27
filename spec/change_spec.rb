require 'change'
require 'coin'

RSpec.describe Change do
  let(:paid_coins) { [Coin.new('10p', 10, 9), Coin.new('50p', 50, 2)] }
  let(:avaliable_coins) do
    [
      Coin.new('1p', 1, 3),
      Coin.new('2p', 2, 3),
      Coin.new('5p', 5, 3),
      Coin.new('10p', 10, 3),
      Coin.new('20p', 20, 3),
      Coin.new('50p', 50, 3),
      Coin.new('1£', 100, 3),
      Coin.new('2£', 200, 3)
    ]
  end

  describe '#calculate' do
    describe 'when it is possible to return change' do
      it 'it returns coins values' do
        change = Change.new(10, paid_coins, avaliable_coins)
        expect(change.calculate).to eq([100, 50, 20, 10])
      end
    end

    describe 'when it is not possible to return change' do
      it 'raises and error' do
        change = Change.new(10, paid_coins, [])
        expect { change.calculate }.to raise_error(InsufficientCoinsError)
      end
    end
  end
end

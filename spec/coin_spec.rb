require 'coin'

RSpec.describe Coin do
  subject(:coin) { described_class.new('1p', 1, 10) }

  describe '#increase_quantity' do
    it 'increases coin quantity' do
      coin.increase_quantity(10)
      expect(coin.quantity).to eq(20)
    end
  end

  describe '#increase_quantity' do
    it 'increases coin quantity' do
      coin.decrease_quantity(5)
      expect(coin.quantity).to eq(5)
    end
  end

  describe '#cumulative_value' do
    it 'returns cumulative value of coins' do
      expect(coin.cumulative_value).to eq(10)
    end
  end
end

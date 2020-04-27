require 'coin'

RSpec.describe Coin do
  subject(:coin) { described_class.new('1p', 1, 10) }

  describe '#increase_quantity' do
    it 'increases coin quantity' do
      coin.increase_quantity(10)
      expect(coin.quantity).to eq(20)
    end
  end
end

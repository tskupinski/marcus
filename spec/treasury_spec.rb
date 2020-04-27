require 'treasury'

RSpec.describe Treasury do
  subject(:treasury) { described_class.new }
  describe '#add_coin' do
    it 'adds the coin to change holder' do
      treasury.add_coin('1p')

      expect(treasury.coins.count).to eq(1)
      expect(treasury.coins[0].denomination).to eq('1p')
      expect(treasury.coins[0].value).to eq(1)
    end
  end
end

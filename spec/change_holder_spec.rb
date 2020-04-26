require 'change_holder'

RSpec.describe ChangeHolder do
  subject(:change_holder) { described_class.new }
  describe '#add_coin' do
    it 'adds the coin to change holder' do
      change_holder.add_coin('1p')

      expect(change_holder.coins.count).to eq(1)
      expect(change_holder.coins[0].denomination).to eq('1p')
      expect(change_holder.coins[0].value).to eq(1)
    end
  end
end

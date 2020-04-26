require 'transaction'
require 'inventory'

RSpec.describe Transaction do
  subject(:transaction) { Transaction.new }

  describe '.from_product' do
    context 'when provided name matches product in the inventory' do
      it 'creates new transaction and sets product' do
        result = Transaction.from_product('Mars', Inventory.new)

        expect(result).to be_kind_of(Transaction)
        expect(result.product).to be_kind_of(Product)
      end
    end

    context 'when the product cannot be fetched from inventory' do
      it 'creates new transaction without a product' do
        result = Transaction.from_product('invalid_product', Inventory.new)

        expect(result).to be_kind_of(Transaction)
        expect(result.product).to eq(nil)
      end
    end
  end

  describe '#add_coin' do
    it 'adds coin to the transaction' do
      transaction.add_coin('1p')

      expect(transaction.coins.count).to eq(1)
      expect(transaction.coins[0].denomination).to eq('1p')
      expect(transaction.coins[0].value).to eq(1)
    end
  end
end

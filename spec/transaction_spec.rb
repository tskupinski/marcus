require 'transaction'
require 'inventory'

RSpec.describe Transaction do
  subject(:transaction) { Transaction.new }

  describe '.from_product' do
    context 'when provided name matches product in the inventory' do
      it 'creates new transaction and sets product' do
        result = Transaction.from_product('Mars', Inventory.new)

        expect(result).to be_kind_of(Transaction)
        expect(result.product.name).to eq('Mars')
        expect(result.product.price).to eq(100)
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
    context 'when the coin of given denomination is already part of transaction' do
      before { transaction.coins = [Coin.new('1p', 1, 1)] }

      it 'increases the coin count' do
        transaction.add_coin('1p')

        expect(transaction.coins.count).to eq(1)
        expect(transaction.coins[0].denomination).to eq('1p')
        expect(transaction.coins[0].quantity).to eq(2)
      end
    end
    context 'when the coin of given denomination is not a part of transaction' do
      before { transaction.coins = [] }

      it 'adds coin to transaction and sets it quantity to 1' do
        transaction.add_coin('1p')

        expect(transaction.coins.count).to eq(1)
        expect(transaction.coins[0].denomination).to eq('1p')
        expect(transaction.coins[0].quantity).to eq(1)
      end
    end
  end
end

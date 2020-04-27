require 'transaction'
require 'inventory'

RSpec.describe Transaction do
  subject(:transaction) { Transaction.new }

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

  describe '#paid_in_full?' do
    context 'when the coins cumulative value matches the product price' do
      it 'returns true' do
        transaction = Transaction.new(Product.new('Mars', 100, 10))
        transaction.add_coin('50p')
        transaction.add_coin('20p')
        transaction.add_coin('10p')
        transaction.add_coin('10p')
        transaction.add_coin('10p')

        expect(transaction.paid_in_full?).to eq(true)
      end
    end

    context 'when the coins cumulative is lower than product price' do
      it 'returns true' do
        transaction = Transaction.new(Product.new('Mars', 100, 10))
        transaction.add_coin('50p')

        expect(transaction.paid_in_full?).to eq(false)
      end
    end
  end

  describe '#remaining_payment' do
    it 'returns the remaining due amount' do
      transaction = Transaction.new(Product.new('Mars', 100, 10))
      transaction.add_coin('50p')

      expect(transaction.remaining_payment).to eq(50)
    end
  end

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
      it 'raises and error' do
        expect { Transaction.from_product('invalid_product', Inventory.new) }.to(raise_error(UnsupportedProductError))
      end
    end
  end
end

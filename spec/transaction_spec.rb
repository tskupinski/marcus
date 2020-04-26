require 'transaction'
require 'inventory'

RSpec.describe Transaction do
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
end

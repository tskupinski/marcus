require 'inventory'

RSpec.describe Inventory do
  subject(:inventory) { described_class.new }

  describe '#products' do
    it 'sets the starting list of avaliable products' do
      expect(inventory.products).to be_kind_of(Array)
      expect(inventory.products[0]).to be_kind_of(Product)
      expect(inventory.products[0].name).to eq('Mars')
      expect(inventory.products[0].price).to eq(100)
    end
  end

  describe '#fetch_product' do
    context 'when the product name matches product in the inventory' do
      before { inventory.products = [Product.new('Mars', 100, 10)] }

      it 'returns the product' do
        result = inventory.fetch_product('Mars')

        expect(result.name).to eq('Mars')
        expect(result.price).to eq(100)
      end
    end

    context 'when the product name does not match any product in the inventory' do
      before { inventory.products = [] }

      it 'returns nil' do
        result = inventory.fetch_product('invalid_product')

        expect(result).to eq(nil)
      end
    end

    context 'when the product matches the product in the inventory but its quantity is equal 0' do
      before { inventory.products = [Product.new('Mars', 100, 0)] }
      it 'returns  nil' do
        result = inventory.fetch_product('Mars')

        expect(result).to eq(nil)
      end
    end
  end

  describe '#add_product' do
    context 'when the product is present in the inventory' do
      before { inventory.products = [Product.new('Mars', 100, 10)] }

      it 'increases product quantity' do
        inventory.add_product('Mars', 10)
        expect(inventory.products[0].quantity).to eq(20)
      end
    end

    context 'when provided name does not mach product in the inventory' do
      before { inventory.products = [] }

      it 'raises an error' do
        expect{ inventory.add_product('invalid_product', 10) }.to(raise_error(UnsupportedProductError))
      end
    end
  end

  describe '#release_product' do
    it 'removes product from inventory' do
      inventory.products = [Product.new('Mars', 100, 10)]

      inventory.release_product('Mars')

      expect(inventory.products[0].quantity).to eq(9)
    end
  end

end

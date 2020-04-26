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

  describe '#list_products' do
    it 'lists the products with price' do
      expect(inventory.list_products).to be_kind_of(Array)
      expect(inventory.list_products[0]).to eq("#{subject.products[0].name}, price: #{subject.products[0].price} p")
    end
  end

  describe '#fetch_product' do
    context 'when the product name matches product in the inventory' do
      it 'returns the product' do
        result = inventory.fetch_product('Mars')

        expect(result).to be_kind_of(Product)
        expect(result.name).to eq('Mars')
        expect(result.price).to eq(100)
      end
    end

    context 'when the product name does not match any product in the inventory' do
      it 'returns nil' do
        result = inventory.fetch_product('invalid_product')

        expect(result).to eq(nil)
      end
    end
  end
end

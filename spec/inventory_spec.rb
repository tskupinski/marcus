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
end

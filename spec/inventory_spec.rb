require 'inventory'

RSpec.describe Inventory do
  subject(:inventory) { described_class.new }
  describe '#products' do
    it 'returns the list of products' do
      expect(inventory.products).to be_kind_of(Array)
      expect(inventory.products[0]).to be_kind_of(Product)
    end
  end
end

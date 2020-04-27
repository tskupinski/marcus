require 'product'

RSpec.describe Product do
  subject(:product) { described_class.new('Mars', 100, 10) }

  describe '#increase_quantity' do
    it 'increases product quantity' do
      product.increase_quantity(1)
      expect(product.quantity).to eq(11)
    end
  end
end

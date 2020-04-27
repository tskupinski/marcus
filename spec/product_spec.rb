require 'product'

RSpec.describe Product do
  subject(:product) { described_class.new('Mars', 100, 10) }

  describe '#increase_quantity' do
    it 'increases product quantity' do
      product.increase_quantity(1)
      expect(product.quantity).to eq(11)
    end
  end

  describe '#avaliable?' do
    context 'when the product quantity is greater than 0' do
      it 'returns true' do
        expect(product.avaliable?).to eq(true)
      end
    end

    context 'when the product quantity equals 0' do
      it 'returns false' do
        out_of_stock_product = Product.new('Mars', 10, 0)
        expect(out_of_stock_product.avaliable?).to eq(false)
      end
    end
  end
end

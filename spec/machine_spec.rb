require 'machine'

RSpec.describe Machine do
  subject(:machine) { described_class.new }
  describe '#list_products' do
    it 'returns the list of products' do
      expect(machine.list_products).to be_kind_of(Array)
      expect(machine.list_products[0]).to be_kind_of(Product)
    end
  end
end

require 'machine'

RSpec.describe Machine do
  subject(:machine) { described_class.new }

  describe '#list_products' do
    it 'returns the list of products' do
      expect(machine.list_products).to be_kind_of(Array)
    end
  end

  describe '#select_product' do
    it 'creates the transaction' do
      machine.select_product('Mars')
      expect(machine.transaction).to be_kind_of(Transaction)
    end
  end
end

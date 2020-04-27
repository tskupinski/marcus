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

  describe '#insert_coin' do
    it 'adds coin to transaction' do
      expect(machine.transaction).to receive(:add_coin)
      machine.insert_coin('1p')
    end
  end

  describe '#add_to_treasury' do
    it 'adds coin to treasury' do
      expect(machine.treasury).to receive(:add_coin)
      machine.add_to_treasury('1p')
    end
  end
end

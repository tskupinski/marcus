require 'machine'

RSpec.describe Machine do
  subject(:machine) { described_class.new }

  describe '#restock_product' do
    it 'adds product to inventory' do
      expect(machine.inventory).to receive(:add_product)
      machine.restock_product('Mars', 10)
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
      expect(machine.treasury).to receive(:restock_coins)
      machine.add_to_treasury('1p', 1)
    end
  end

  describe '#release_product' do
    it 'decreases product quantity in the inventory and finishes the transaction' do
      expect(machine.inventory).to receive(:release_product)
      machine.release_product('Mars')
    end
  end

  describe '#clear_transaction' do
    before { machine.transaction = Transaction.new }

    it 'clears the transaction' do
      machine.clear_transaction
      expect(machine.transaction).to eq(nil)
    end
  end
end

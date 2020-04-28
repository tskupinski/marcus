require 'marcus_commands/select'
require 'machine'
require 'printer'

RSpec.describe MarcusCommands::Select do
  let(:machine) { Machine.new(Inventory.new, Treasury.new, printer) }
  let(:printer) { Printer.new }

  context 'when there is already active transaction' do
    before { machine.select_product('Mars') }

    it 'notifies about existing transaction' do
      expect(printer).to receive(:transaction_exists)
      described_class.new('Mars', machine, nil, nil, printer).execute
    end
  end

  context 'when machine has no existing transaction' do
    it 'selects the product' do
      described_class.new('Mars', machine, nil, nil, printer).execute
      expect(machine.transaction.product.name).to eq('Mars')
    end

    it 'prints out new transaction details' do
      expect(printer).to receive(:transaction_details)
      described_class.new('Mars', machine, nil, nil, printer).execute
    end
  end

  context 'when the product is not supported' do
    it 'prints out error message' do
      expect(printer).to receive(:message)
      described_class.new('invalid_product', machine, nil, nil, printer).execute
    end
  end
end

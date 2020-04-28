require 'marcus_commands/restock'
require 'machine'
require 'printer'

RSpec.describe MarcusCommands::Restock do
  let(:machine) { Machine.new(Inventory.new, Treasury.new, printer) }
  let(:printer) { Printer.new }

  before { machine.inventory.products = [Product.new('Mars', 100, 10)] }

  context 'when the selected product is supported by machine' do
    it 'adds product to machines inventory' do
      described_class.new('Mars 10', machine, nil, nil, printer).execute
      expect(machine.inventory.products[0].quantity).to eq(20)
    end

    it 'prints product restocked notification' do
      expect(printer).to receive(:products_restocked)
      described_class.new('Mars 10', machine, nil, nil, printer).execute
    end
  end

  context 'when the product is not supported' do
    it 'prints out error message' do
      expect(printer).to receive(:message)
      described_class.new('invalid_product', machine, nil, nil, printer).execute
    end
  end
end

require 'marcus_commands/list'
require 'inventory'
require 'printer'

RSpec.describe MarcusCommands::List do
  let(:inventory) { Inventory.new }
  let(:printer) { Printer.new }
  context 'when there are products with positive quantity in the inventory' do
    before { inventory.products = [Product.new('Mars', 100, 10), Product.new('Oreo', 50, 5)] }

    it 'prints products list' do
      expect(printer).to receive(:product_details).twice
      described_class.new(nil, nil, inventory, nil, printer).execute
    end
  end

  context 'without products with positive quantity in the inventory' do
    before { inventory.products = [Product.new('Mars', 100, 0), Product.new('Oreo', 50, 0)] }

    it 'prints products list' do
      expect(printer).not_to receive(:product_details)
      described_class.new(nil, nil, inventory, nil, printer).execute
    end
  end
end

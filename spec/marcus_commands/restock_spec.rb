require 'marcus_commands/restock'
require 'machine'

RSpec.describe MarcusCommands::Restock do
  let(:machine) { Machine.new }

  before { machine.inventory.products = [Product.new('Mars', 100, 10)] }

  context 'when the selected product is supported by machine' do
    it 'adds product to machines inventory' do
      described_class.new('Mars 10', machine, nil, nil).execute
      expect(machine.inventory.products[0].quantity).to eq(20)
    end
  end
end

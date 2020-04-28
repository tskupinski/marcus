require 'marcus_commands/select'
require 'machine'
require 'printer'

RSpec.describe MarcusCommands::Select do
  let(:machine) { Machine.new }
  let(:printer) { Printer.new }

  context 'when machine has no existing transaction' do
    it 'selects the product' do
      described_class.new('Mars', machine, nil, nil, printer).execute
      expect(machine.transaction.product.name).to eq('Mars')
    end
  end
end

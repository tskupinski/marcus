require 'marcus_commands/abort'
require 'machine'
require 'printer'

RSpec.describe MarcusCommands::Abort do
  let(:machine) { Machine.new }
  let(:printer) { Printer.new }

  context 'when machine has existing transaction' do
    before { machine.select_product('Mars') }

    it 'aborts the transaction' do
      described_class.new(nil, machine, nil, nil, printer).execute

      expect(machine.transaction).to eq(nil)
    end
  end
end

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

    it 'prints out transaction abortion confirmation' do
      expect(printer).to receive(:transaction_aborted)
      described_class.new(nil, machine, nil, nil, printer).execute
    end
  end

  context 'when there is no existing transaction' do
    it 'prints out no transaction notification' do
      expect(printer).to receive(:no_transaction)
      described_class.new(nil, machine, nil, nil, printer).execute
    end
  end
end

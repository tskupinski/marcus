require 'marcus_commands/abort'
require 'machine'

RSpec.describe MarcusCommands::Abort do
  let(:machine) { Machine.new }
  context 'when machine has existing transaction' do
    before { machine.select_product('Mars') }

    it 'aborts the transaction' do
      described_class.new(nil, machine, nil, nil).execute

      expect(machine.transaction).to eq(nil)
    end
  end
end

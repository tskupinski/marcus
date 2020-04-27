RSpec.describe MarcusCommands::Abort do
  let(:machine) { Machine.new }
  context 'when machine has existing transaction' do
    before { machine.select_product('Mars') }

    it 'aborts the transaction' do

    end

  end
end

require 'command_factory'
require 'command_input'
require 'machine'
require 'treasury'
require 'inventory'

RSpec.describe CommandFactory do
  subject { described_class.build(command_input, Machine.new, Treasury.new, Inventory.new) }

  describe '.build' do
    context 'with list instruction' do
      let(:command_input) { CommandInput.from_text('list') }

      it { is_expected.to be_a(MarcusCommands::List) }
    end

    context 'with select instruction' do
      let(:command_input) { CommandInput.from_text('select') }

      it { is_expected.to be_a(MarcusCommands::Select) }
    end

    context 'with invalid instruction' do
      let(:command_input) { CommandInput.from_text('invalid') }

      it { is_expected.to be_a(MarcusCommands::NotFound) }
    end
  end
end

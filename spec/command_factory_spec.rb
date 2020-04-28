require 'command_factory'
require 'command_input'
require 'machine'
require 'treasury'
require 'inventory'

RSpec.describe CommandFactory do
  subject { described_class.build(command_input, Machine.new, Treasury.new, Inventory.new, Printer.new) }

  describe '.build' do
    context 'with list instruction' do
      let(:command_input) { CommandInput.from_text('list') }

      it { is_expected.to be_a(MarcusCommands::List) }
    end

    context 'with select instruction' do
      let(:command_input) { CommandInput.from_text('select') }

      it { is_expected.to be_a(MarcusCommands::Select) }
    end

    context 'with insert instruction' do
      let(:command_input) { CommandInput.from_text('insert') }

      it { is_expected.to be_a(MarcusCommands::Insert) }
    end

    context 'with abort instruction' do
      let(:command_input) { CommandInput.from_text('abort') }

      it { is_expected.to be_a(MarcusCommands::Abort) }
    end

    context 'with add instruction' do
      let(:command_input) { CommandInput.from_text('add') }

      it { is_expected.to be_a(MarcusCommands::Add) }
    end

    context 'with restock instruction' do
      let(:command_input) { CommandInput.from_text('restock') }

      it { is_expected.to be_a(MarcusCommands::Restock) }
    end

    context 'with help instruction' do
      let(:command_input) { CommandInput.from_text('help') }

      it { is_expected.to be_a(MarcusCommands::Help) }
    end

    context 'with invalid instruction' do
      let(:command_input) { CommandInput.from_text('invalid') }

      it { is_expected.to be_a(MarcusCommands::NotFound) }
    end
  end
end

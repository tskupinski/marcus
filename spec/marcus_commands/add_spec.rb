require 'marcus_commands/add'
require 'machine'
require 'printer'

RSpec.describe MarcusCommands::Add do
  let(:machine) { Machine.new }
  let(:printer) { Printer.new }

  context 'when the coin is supported' do
    before { machine.treasury.coins = [Coin.new('1p', 1, 10)] }

    it 'adds the coins to machine treasury' do
      described_class.new('1p 10', machine, nil, nil, printer).execute
      expect(machine.treasury.coins[0].quantity).to eq(20)
    end

    it 'prints coins added notification' do
      expect(printer).to receive(:coins_added)
      described_class.new('1p 10', machine, nil, nil, printer).execute
    end
  end

  context 'when the coin is not supported' do
    before { machine.treasury.coins = [Coin.new('1p', 1, 10)] }

    it 'prints out error message' do
      expect(printer).to receive(:message)
      described_class.new('invalid_coin', machine, nil, nil, printer).execute
    end
  end
end

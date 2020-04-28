require 'marcus_commands/add'
require 'machine'
require 'printer'

RSpec.describe MarcusCommands::Add do
  let(:machine) { Machine.new }
  let(:printer) { Printer.new }

  before { machine.treasury.coins = [Coin.new('1p', 1, 10)] }
  it 'adds the coins to machine treasury' do
    described_class.new('1p 10', machine, nil, nil, printer).execute
    expect(machine.treasury.coins[0].quantity).to eq(20)
  end
end

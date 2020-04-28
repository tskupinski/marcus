require 'marcus_commands/insert'
require 'machine'

RSpec.describe MarcusCommands::Insert do
  let(:machine) { Machine.new }
  let(:printer) { Printer.new }

  context 'when after inserting coin transaction is not yet paid' do
    before do
      machine.inventory.products = [Product.new('Mars', 100, 10)]
      machine.select_product('Mars')
    end

    it 'adds coin to transaction' do
      described_class.new('10p', machine, nil, machine.treasury, printer).execute

      expect(machine.transaction.remaining_payment).to eq(90)
    end
  end

  context 'when after inserting coin transaction is paid' do
    before do
      machine.inventory.products = [Product.new('Mars', 5, 2)]
      machine.treasury.coins = [Coin.new('1p', 1, 10)]
      machine.select_product('Mars')

      described_class.new('10p', machine, nil, machine.treasury, printer).execute
    end

    it 'clears the transaction' do
      expect(machine.transaction).to eq(nil)
    end

    it 'removes coins for returning change from the treasury' do
      expect(machine.treasury.coins[0].quantity).to eq(5)
    end

    it 'removes product from the inventory' do
      expect(machine.inventory.products[0].quantity).to eq(1)
    end
  end
end

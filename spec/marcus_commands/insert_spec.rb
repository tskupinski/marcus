require 'marcus_commands/insert'
require 'machine'
require 'printer'

RSpec.describe MarcusCommands::Insert do
  let(:machine) { Machine.new(Inventory.new, Treasury.new, printer) }
  let(:printer) { Printer.new }

  context 'when there is no active transaction' do
    it 'prints no transaction message' do
      expect(printer).to receive(:no_transaction)
      described_class.new('10p', machine, nil, nil, printer).execute
    end
  end

  context 'when after inserting coin transaction is not yet paid' do
    before do
      machine.inventory.products = [Product.new('Mars', 100, 10)]
      machine.select_product('Mars')
    end

    it 'adds coin to transaction' do
      described_class.new('10p', machine, nil, machine.treasury, printer).execute
      expect(machine.transaction.remaining_payment).to eq(90)
    end

    it 'prints remaining payment due' do
      expect(printer).to receive(:payment_due)
      described_class.new('10p', machine, nil, machine.treasury, printer).execute
    end
  end

  context 'when after inserting coin transaction is paid' do
    before do
      machine.inventory.products = [Product.new('Mars', 5, 2)]
      machine.treasury.coins = [Coin.new('1p', 1, 10)]
      machine.select_product('Mars')
    end

    it 'finalizes_the_transaction' do
      expect(machine).to receive(:finalize_transaction)
      described_class.new('10p', machine, nil, machine.treasury, printer).execute
    end

    it 'clears the transaction' do
      described_class.new('10p', machine, nil, machine.treasury, printer).execute
      expect(machine.transaction).to eq(nil)
    end

    it 'removes coins for returning change from the treasury' do
      described_class.new('10p', machine, nil, machine.treasury, printer).execute
      expect(machine.treasury.coins[0].quantity).to eq(5)
    end

    it 'removes product from the inventory' do
      described_class.new('10p', machine, nil, machine.treasury, printer).execute
      expect(machine.inventory.products[0].quantity).to eq(1)
    end

    it 'releases the product' do
      expect(printer).to receive(:release_product)
      described_class.new('10p', machine, nil, machine.treasury, printer).execute
    end

    it 'returns change' do
      expect(printer).to receive(:release_change)
      described_class.new('10p', machine, nil, machine.treasury, printer).execute
    end
  end

  context 'when the coin is not supported' do
    before do
      machine.inventory.products = [Product.new('Mars', 5, 2)]
      machine.treasury.coins = [Coin.new('1p', 1, 10)]
      machine.select_product('Mars')
    end

    it 'prints out error message' do
      expect(printer).to receive(:message)
      described_class.new('invalid_coin', machine, nil, nil, printer).execute
    end
  end

  context 'when there are insufficient coins in the machine to return change' do
    before do
      machine.inventory.products = [Product.new('Mars', 5, 2)]
      machine.treasury.coins = [Coin.new('1p', 1, 10)]
      machine.select_product('Mars')
    end

    it 'prints out error message' do
      expect(printer).to receive(:message)
      described_class.new('2£', machine, nil, machine.treasury, printer).execute
    end
  end
end

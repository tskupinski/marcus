require 'machine'
require 'printer'

RSpec.describe Machine do
  subject(:machine) { described_class.new(Inventory.new, Treasury.new, printer) }
  subject(:printer) { Printer.new }

  describe '#restock_product' do
    it 'adds product to inventory' do
      expect(machine.inventory).to receive(:add_product)
      expect(printer).to receive(:products_restocked)

      machine.restock_product('Mars', 10)
    end
  end

  describe '#select_product' do
    context 'when there is no active transaction' do
      it 'creates the transaction' do
        machine.select_product('Mars')
        expect(machine.transaction).to be_kind_of(Transaction)
      end

      it 'prints out transaction details' do
        expect(printer).to receive(:transaction_details)
        machine.select_product('Mars')
      end
    end

    context 'when transaction already exists' do
      before { machine.transaction = Transaction.new }

      it 'prints out notification' do
        expect(printer).to receive(:transaction_exists)
        machine.select_product('Mars')
      end
    end
  end

  describe '#insert_coin' do
    context 'when inserted coin would match or exceed payment due' do
      before do
        machine.inventory.products = [Product.new('Mars', 5, 2)]
        machine.treasury.coins = [Coin.new('1p', 1, 10)]
        machine.select_product('Mars')
      end

      it 'adds coin to transaction' do
        expect(machine.transaction).to receive(:add_coin)
        machine.insert_coin('10p')
      end

      it 'removes product from the inventory' do
        machine.insert_coin('10p')
        expect(machine.inventory.products[0].quantity).to eq(1)
      end

      it 'removes coins for returning change from the treasury' do
        machine.insert_coin('10p')
        expect(machine.treasury.coins[0].quantity).to eq(5)
      end

      it 'clears the transaction' do
        machine.insert_coin('10p')
        expect(machine.transaction).to eq(nil)
      end

      it 'releases the product' do
        expect(printer).to receive(:release_product)
        machine.insert_coin('10p')
      end

      it 'returns change' do
        expect(printer).to receive(:release_change)
        machine.insert_coin('10p')
      end
    end

    context 'when inserted coin would not match or exceed payment due' do
      before do
        machine.inventory.products = [Product.new('Mars', 100, 2)]
        machine.treasury.coins = [Coin.new('1p', 1, 10)]
        machine.select_product('Mars')
      end

      it 'prints the payment due value' do
        expect(printer).to receive(:payment_due)
        machine.insert_coin('10p')
      end
    end
  end

  describe '#add_to_treasury' do
    it 'adds coin to treasury' do
      expect(machine.treasury).to receive(:restock_coins)
      machine.add_to_treasury('1p', 1)
    end
  end

  describe '#release_product' do
    it 'decreases product quantity in the inventory and finishes the transaction' do
      expect(machine.inventory).to receive(:release_product)
      machine.release_product('Mars')
    end
  end

  describe '#clear_transaction' do
    before { machine.transaction = Transaction.new }

    it 'clears the transaction' do
      machine.clear_transaction
      expect(machine.transaction).to eq(nil)
    end
  end
end

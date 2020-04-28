require_relative './inventory'
require_relative './transaction'
require_relative './treasury'

class Machine
  def initialize(inventory = Inventory.new, treasury = Treasury.new, printer = Printer.new)
    @inventory = inventory
    @transaction = nil
    @treasury = treasury
    @printer = printer
  end

  attr_reader :treasury, :inventory
  attr_accessor :transaction

  def restock_product(name, amount)
    inventory.add_product(name, amount)
    printer.products_restocked
  end

  def select_product(name)
    if transaction
      printer.transaction_exists
    else
      self.transaction = Transaction.from_product(name, inventory)
      printer.transaction_details(current_product_name, transaction.remaining_payment)
    end
  end

  def insert_coin(denomination)
    transaction.add_coin(denomination)

    if transaction.paid_in_full?
      finalize_transaction
    else
      print_payment_due
    end
  end

  def add_to_treasury(denomination, amount)
    treasury.restock_coins(denomination, amount)
  end

  def release_product(name)
    inventory.release_product(name)
  end

  def clear_transaction
    self.transaction = nil
  end

  private

  attr_reader :printer

  def finalize_transaction
    change = calculate_change

    treasury.subtract_coins(change)
    release_product(current_product_name)

    printer.release_product(current_product_name)
    printer.release_change(change)

    clear_transaction
  end

  def current_product_name
    transaction.product.name
  end

  def calculate_change
    transaction.calculate_change(treasury.coins)
  end

  def print_payment_due
    printer.payment_due(transaction.remaining_payment)
  end
end

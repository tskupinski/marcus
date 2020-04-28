require_relative './inventory'
require_relative './transaction'
require_relative './treasury'

class Machine
  def initialize(inventory = Inventory.new, treasury = Treasury.new)
    @inventory = inventory
    @transaction = nil
    @treasury = treasury
  end

  attr_reader :treasury, :inventory
  attr_accessor :transaction

  def restock_product(name, amount)
    inventory.add_product(name, amount)
  end

  def select_product(name)
    self.transaction = Transaction.from_product(name, inventory)
  end

  def insert_coin(denomination)
    transaction.add_coin(denomination)
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

  def finalize_transaction(printer)
    change = calculate_change

    treasury.subtract_coins(change)
    release_product(current_product_name)

    printer.release_product(current_product_name)
    printer.release_change(change)

    clear_transaction
  end

  private

  def current_product_name
    transaction.product.name
  end

  def calculate_change
    transaction.calculate_change(treasury.coins)
  end
end


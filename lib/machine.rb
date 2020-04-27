require 'inventory'
require 'transaction'
require 'treasury'

class Machine
  def initialize
    @inventory = Inventory.new
    @transaction = nil
    @treasury = Treasury.new
  end

  attr_reader :transaction, :treasury, :inventory

  def list_products
    inventory.list_products
  end

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

  private

  attr_writer :transaction
end


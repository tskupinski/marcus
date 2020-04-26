require 'inventory'
require 'transaction'

class Machine
  def initialize
    @inventory = Inventory.new
    @transaction = nil
  end

  attr_reader :transaction

  def list_products
    inventory.list_products
  end

  def select_product(name)
    self.transaction = Transaction.from_product(name, inventory)
  end

  def insert_coin(coin)
    transaction.add_coin(coin)
  end

  private

  attr_reader :inventory
  attr_writer :transaction
end


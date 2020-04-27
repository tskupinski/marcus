require 'inventory'
require 'transaction'
require 'treasury'

class Machine
  def initialize
    @inventory = Inventory.new
    @transaction = nil
    @treasury = Treasury.new
  end

  attr_reader :transaction, :treasury

  def list_products
    inventory.list_products
  end

  def select_product(name)
    self.transaction = Transaction.from_product(name, inventory)
  end

  def insert_coin(coin)
    transaction.add_coin(coin)
  end

  def add_to_treasury(coin)
    treasury.add_coin(coin)
  end

  private

  attr_reader :inventory
  attr_writer :transaction
end


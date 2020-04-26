require 'inventory'
require 'transaction'
require 'change_holder'

class Machine
  def initialize
    @inventory = Inventory.new
    @transaction = nil
    @change_holder = ChangeHolder.new
  end

  attr_reader :transaction, :change_holder

  def list_products
    inventory.list_products
  end

  def select_product(name)
    self.transaction = Transaction.from_product(name, inventory)
  end

  def insert_coin(coin)
    transaction.add_coin(coin)
  end

  def add_to_change_holder(coin)
    change_holder.add_coin(coin)
  end

  private

  attr_reader :inventory
  attr_writer :transaction, :change_holder
end


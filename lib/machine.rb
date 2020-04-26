require 'forwardable'
require 'inventory'

class Machine
  def initialize(inventory = Inventory.new)
    @inventory = inventory
  end

  def list_products
    inventory.list_products
  end

  private

  attr_reader :inventory
end

require 'product'

class Inventory
  STARTING_STOCK = [Product.new, Product.new, Product.new].freeze

  def initialize(products = STARTING_STOCK)
    @products = products
  end

  attr_reader :products
end

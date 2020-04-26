require 'product'

class Inventory
  STARTING_STOCK = [
    Product.new('Mars', 100), Product.new('Water', 50), Product.new('Cola', 75)
  ].freeze

  def initialize
    @products = STARTING_STOCK
  end

  attr_reader :products

  def list_products
    products.map { |p| "#{p.name}, price: #{p.price} p" }
  end

  def fetch_product(name)
    products.find { |p| p.name == name }
  end
end

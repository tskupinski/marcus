require 'product'
# TODO: Move to another file
class UnsupportedProductError < StandardError; end

class Inventory
  STARTING_STOCK = [
    Product.new('Mars', 100, 10), Product.new('Water', 50, 10), Product.new('Cola', 75, 10)
  ].freeze

  def initialize(products = STARTING_STOCK)
    @products = products
  end

  attr_accessor :products

  def list_products
    products.map { |p| "#{p.name}, price: #{p.price} p" }
  end

  def fetch_product(name)
    products.find { |p| p.name == name }
  end

  def add_product(name, amount)
    product = products.find { |p| p.name == name } || raise_error
    product.increase_quantity(amount)
  end

  private

  def raise_error
    raise UnsupportedProductError, 'Invalid product, please restock one of avaliable types'
  end
end

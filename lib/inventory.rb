require_relative './product'
require_relative './errors/unsupported_product_error'

class Inventory
  STARTING_STOCK = [
    Product.new('Mars', 100, 10),
    Product.new('Water', 50, 10),
    Product.new('Cola', 75, 10),
    Product.new('Oero', 20, 10),
    Product.new('Glove', 127, 10),
    Product.new('Tissue', 15, 10),
    Product.new('Mask', 300, 10)
  ].freeze

  def initialize(products = STARTING_STOCK)
    @products = products
  end

  attr_accessor :products

  def fetch_product(name)
    product = products.find { |p| p.name == name }
    return product if product&.avaliable?
  end

  def add_product(name, amount)
    product = products.find { |p| p.name == name } || raise_error
    product.increase_quantity(amount)
  end

  def release_product(name)
    product = products.find { |p| p.name == name }
    product.decrease_quantity(1)
  end

  private

  def raise_error
    raise UnsupportedProductError, 'Invalid product, please restock one of avaliable types'
  end
end

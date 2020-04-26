class Transaction
  def initialize(product)
    @product = product
  end

  attr_reader :product

  def self.from_product(name, inventory)
    product = inventory.fetch_product(name)
    # TODO Consider raising error when product was not found

    new(product)
  end
end

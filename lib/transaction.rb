require 'coin'
require 'coins_factory'

class Transaction
  def initialize(product = nil)
    @product = product
    @coins = []
  end

  attr_reader :product, :coins

  def self.from_product(name, inventory)
    product = inventory.fetch_product(name)
    # TODO Consider raising error when product was not found

    new(product)
  end

  def add_coin(coin)
    coins << CoinsFactory.build(coin)
  end
end

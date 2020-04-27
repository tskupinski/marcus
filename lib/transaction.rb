require 'coin'
require 'coins_factory'

class Transaction
  def initialize(product = nil)
    @product = product
    @coins = []
  end

  attr_reader :product
  attr_accessor :coins

  def self.from_product(name, inventory)
    product = inventory.fetch_product(name)
    # TODO Consider raising error when product was not found
    # DO IT

    new(product)
  end

  def add_coin(denomination)
    # FIXME: Get rid of conditional
    coin = coins.find { |c| c.denomination == denomination }

    if coin
      coin.increase_quantity(1)
    else
      coins << CoinsFactory.build(denomination)
    end
  end
end

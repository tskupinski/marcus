require_relative './coin'
require_relative './coins_factory'
require_relative './change'

# TODO: Move to another file
class UnsupportedProductError < StandardError; end

class Transaction
  def initialize(product = nil)
    @product = product
    @coins = []
  end

  attr_reader :product
  attr_accessor :coins

  def add_coin(denomination)
    coin = coins.find { |c| c.denomination == denomination }

    if coin
      coin.increase_quantity(1)
    else
      coins << CoinsFactory.build(denomination)
    end
  end

  def paid_in_full?
    coins.sum(&:cumulative_value) >= product.price
  end

  def remaining_payment
    product.price - coins.sum(&:cumulative_value)
  end

  def calculate_change(avaliable_coins)
    Change.new(product.price, coins, avaliable_coins).calculate
  end

  class << self
    def from_product(name, inventory)
      product = inventory.fetch_product(name) || raise_error

      new(product)
    end

    private

    def raise_error
      raise UnsupportedProductError, 'Unavaliable product - please select one from list'
    end
  end
end

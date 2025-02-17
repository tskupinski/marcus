require_relative './coin'
require_relative './errors/unsupported_coin_error'

class Treasury
  STARTING_COINS = [
    Coin.new('1p', 1, 10),
    Coin.new('2p', 2, 10),
    Coin.new('5p', 5, 10),
    Coin.new('10p', 10, 10),
    Coin.new('20p', 20, 10),
    Coin.new('50p', 50, 10),
    Coin.new('1£', 100, 10),
    Coin.new('2£', 200, 10)
  ].freeze

  def initialize(coins = STARTING_COINS)
    @coins = coins
  end

  attr_accessor :coins

  def restock_coins(denomination, amount)
    coin = coins.find { |c| c.denomination == denomination } || raise_error
    coin.increase_quantity(amount)
  end

  def subtract_coins(denominations)
    denominations.each do |denomination|
      coin = coins.find { |c| c.denomination == denomination }
      coin.decrease_quantity(1)
    end
  end

  private

  def raise_error
    raise UnsupportedCoinError, 'Unsupported coin, please use one of supported denominations'
  end
end

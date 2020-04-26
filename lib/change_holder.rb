require 'coins_factory'

class ChangeHolder
  def initialize
    @coins = []
  end

  attr_reader :coins

  def add_coin(coin)
    coins << CoinsFactory.build(coin)
  end
end

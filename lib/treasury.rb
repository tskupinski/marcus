require 'coins_factory'

class Treasury
  def initialize
    @coins = []
  end

  attr_reader :coins

  def add_coin(coin)
    coins << CoinsFactory.build(coin)
  end
end

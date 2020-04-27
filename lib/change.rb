class InsufficientCoinsError < StandardError; end

class Change
  def initialize(price, paid_coins, avaliable_coins)
    @price = price
    @paid_coins = paid_coins
    @avaliable_coins = avaliable_coins
  end

  attr_reader :price, :paid_coins, :avaliable_coins

  def calculate
    due_amount = paid_coins.sum(&:cumulative_value) - price

    change_coins = avaliable_coins.map do |coin|
      [coin.value] * coin.quantity
    end.flatten.sort.reverse

    result = []

    change_coins.each do |coin|
      next unless (due_amount / coin).to_int.positive?

      result << coin
      due_amount -= coin
      change_coins.delete_at(change_coins.index(coin))
    end

    raise_error if due_amount.positive?

    result
  end

  private

  def raise_error
    raise InsufficientCoinsError, 'Insufficient coins to return your change, aborting transaction'
  end
end

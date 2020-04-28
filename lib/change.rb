class InsufficientCoinsError < StandardError; end

class Change
  VALUE_TO_DENOMINATION_MAP = {
    1 => '1p',
    2 => '2p',
    5 => '5p',
    10 => '10p',
    20 => '20p',
    50 => '50p',
    100 => '1£',
    200 => '2£'
  }.freeze


  def initialize(price, paid_coins, avaliable_coins)
    @price = price
    @paid_coins = paid_coins
    @avaliable_coins = avaliable_coins
  end

  attr_reader :price, :paid_coins, :avaliable_coins

  def calculate
    due_amount = calculate_due_amount

    change_coins = avaliable_coins_values

    result = []

    change_coins.each do |coin|
      next unless (due_amount / coin).to_int.positive?

      result << coin
      due_amount -= coin
      change_coins.delete_at(change_coins.index(coin))
    end

    raise_error if due_amount.positive?

    values_to_denominations(result)
  end

  private

  def calculate_due_amount
    paid_coins.sum(&:cumulative_value) - price
  end

  def avaliable_coins_values
    avaliable_coins.map do |coin|
      [coin.value] * coin.quantity
    end.flatten.sort.reverse
  end

  def raise_error
    raise InsufficientCoinsError, 'Insufficient coins to return your change, aborting transaction'
  end

  def values_to_denominations(values)
    values.map { |v| VALUE_TO_DENOMINATION_MAP.fetch(v) }
  end
end

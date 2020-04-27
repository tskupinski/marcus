class Coin
  def initialize(denomination, value, quantity)
    @denomination = denomination
    @value = value
    @quantity = quantity
  end

  attr_reader :denomination, :value
  attr_accessor :quantity

  def increase_quantity(amount)
    self.quantity += amount
  end
end

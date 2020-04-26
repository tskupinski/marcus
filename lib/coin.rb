class Coin
  def initialize(denomination, value)
    @denomination = denomination
    @value = value
  end

  attr_reader :denomination, :value
end

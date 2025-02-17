require_relative './coin'
require_relative './unsupported_coin'

class CoinsFactory
  VALID_DENOMINATIONS_VALUE_MAP = {
    '1p' => 1,
    '2p' => 2,
    '5p' => 5,
    '10p' => 10,
    '20p' => 20,
    '50p' => 50,
    '1£' => 100,
    '2£' => 200
  }.freeze

  def self.build(denomination)
    value = VALID_DENOMINATIONS_VALUE_MAP[denomination] || UnsupportedCoin.new
    Coin.new(denomination, value, 1)
  end
end

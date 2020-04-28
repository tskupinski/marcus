class UnsupportedCoin
  def initialize
    raise UnsupportedCoinError, 'Unsupported coin, please use one of supported denominations'
  end
end

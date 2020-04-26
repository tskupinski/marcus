# TODO: Move error to separate file
class UnsupportedCoinError < StandardError; end

class UnsupportedCoin
  def initialize
    raise UnsupportedCoinError, 'Unsupported coin, please use one of supported denominations'
  end
end

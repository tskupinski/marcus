class Product
  def initialize(name, price, quantity)
    @name = name
    @price = price
    @quantity = quantity
  end

  attr_reader :name, :price
  attr_accessor :quantity

  def increase_quantity(amount)
    self.quantity += amount
  end

  def decrease_quantity(amount)
    self.quantity -= amount
  end

  def avaliable?
    quantity.positive?
  end
end

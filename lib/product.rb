class Product
  def initialize(name, price, quantity)
    @name = name
    @price = price
    @quantity = quantity
  end

  attr_reader :name, :price#, :quantity
  attr_accessor :quantity

  def increase_quantity(amount)
    self.quantity += amount
  end
end

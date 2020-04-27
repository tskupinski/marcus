module MarcusCommands
  class List
    def initialize(_details, _machine, inventory, _treasury)
      @inventory = inventory
    end

    def execute
      inventory.products.each do |product|
        next if product.quantity <= 0

        print_product_details(product.name, product.price_in_pounds, product.quantity)
      end
    end

    private

    attr_reader :inventory

    def print_product_details(name, price_in_pounds, quantity)
      puts "#{name} at a price of #{price_in_pounds}, still #{quantity} in stock"
    end
  end
end

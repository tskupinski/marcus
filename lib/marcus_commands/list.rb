module MarcusCommands
  class List
    def initialize(details, machine, inventory, treasury)
      @details = details
      @machine = machine
      @inventory = inventory
      @treasury = treasury
    end

    def execute
      inventory.products.each do |product|
        next if product.quantity <= 0

        print_product_details(product)
      end
    end

    private

    attr_reader :inventory

    def print_product_details(product)
      puts "#{product.name} at a price of #{product.price_in_pounds}"
    end
  end
end

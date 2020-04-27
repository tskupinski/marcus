module MarcusCommands
  class Restock
    def initialize(details, machine, _inventory, _treasury)
      @details = details
      @machine = machine
    end

    def execute
      name, amount = details&.split(' ')

      machine.restock_product(name.capitalize, amount.to_i)

      print_products_added
    rescue UnsupportedProductError => e
      puts e.message
    end

    private

    attr_reader :machine, :details

    def print_products_added
      puts 'Products added to machine inventory!'
    end
  end
end

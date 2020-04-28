module MarcusCommands
  class Restock
    def initialize(details, machine, _inventory, _treasury, printer)
      @details = details
      @machine = machine
      @printer = printer
    end

    def execute
      name, amount = details&.split(' ')
      machine.restock_product(name.capitalize, amount.to_i)
    rescue UnsupportedProductError => e
      printer.message(e.message)
    end

    private

    attr_reader :machine, :details, :printer
  end
end

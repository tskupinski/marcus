module MarcusCommands
  class Select
    def initialize(details, machine, _inventory, _treasury, printer)
      @details = details
      @machine = machine
      @printer = printer
    end

    def execute
      machine.select_product(details&.capitalize)
    rescue UnsupportedProductError => e
      printer.message(e.message)
    end

    private

    attr_reader :machine, :details, :printer
  end
end

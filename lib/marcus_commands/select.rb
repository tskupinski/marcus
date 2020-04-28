module MarcusCommands
  class Select
    def initialize(details, machine, _inventory, _treasury, printer)
      @details = details
      @machine = machine
      @printer = printer
    end

    def execute
      if machine.transaction
        printer.transaction_exists
      else
        transaction = machine.select_product(details&.capitalize)
        printer.transaction_details(transaction.product.name, transaction.remaining_payment)
      end
    rescue UnsupportedProductError => e
      printer.message(e.message)
    end

    private

    attr_reader :machine, :details, :printer
  end
end

module MarcusCommands
  class Insert
    def initialize(details, machine, _inventory, treasury, printer)
      @details = details
      @machine = machine
      @treasury = treasury
      @printer = printer
    end

    def execute
      return printer.no_transaction unless machine.transaction

      machine.insert_coin(details)
    rescue InsufficientCoinsError => e
      printer.message(e.message)
    rescue UnsupportedCoinError => e
      printer.message(e.message)
    end

    private

    attr_reader :machine, :details, :treasury, :printer

    def current_product_name
      machine.transaction.product.name
    end
  end
end

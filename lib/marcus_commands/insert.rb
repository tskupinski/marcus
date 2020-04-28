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

      if machine.transaction.paid_in_full?
        machine.finalize_transaction(printer)
      else
        print_payment_due
      end
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

    def print_payment_due
      printer.payment_due(machine.transaction.remaining_payment)
    end
  end
end

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
        product = machine.transaction.product

        change_values = machine.transaction.calculate_change(treasury.coins)

        treasury.subtract_coins(change_values)

        machine.release_product(product.name)

        printer.release_product(product.name)
        printer.release_change(change_values)

        machine.clear_transaction
      else
        printer.payment_due(machine.transaction.remaining_payment)
      end
    rescue InsufficientCoinsError => e
      printer.message(e.message)
    rescue UnsupportedCoinError => e
      printer.message(e.message)
    end

    private

    attr_reader :machine, :details, :treasury, :printer
  end
end

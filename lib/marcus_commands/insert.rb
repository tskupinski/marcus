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
        finalize_transaction
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

    def finalize_transaction
      change = calculate_change

      treasury.subtract_coins(change)

      machine.release_product(current_product_name)

      printer.release_product(current_product_name)
      printer.release_change(change)

      machine.clear_transaction
    end

    def current_product_name
      machine.transaction.product.name
    end

    def calculate_change
      machine.transaction.calculate_change(treasury.coins)
    end

    def print_payment_due
      printer.payment_due(machine.transaction.remaining_payment)
    end
  end
end

module MarcusCommands
  class Select
    def initialize(details, machine, _inventory, _treasury)
      @details = details
      @machine = machine
    end

    def execute
      if machine.transaction
        print_transaction_exists
      else
        transaction = machine.select_product(details&.capitalize)
        print_transaction_details(transaction)
      end
    rescue UnsupportedProductError => e
      puts e.message
    end

    private

    attr_reader :machine, :details

    def print_transaction_exists
      puts 'Please finish or abort current transaction'
    end

    def print_transaction_details(transaction)
      puts "You have selected #{transaction.product.name}"
      puts "Please pay #{transaction.remaining_payment}p to receive your merchandise"
    end
  end
end

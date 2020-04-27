module MarcusCommands
  class Select
    def initialize(details, machine, inventory, treasury)
      @details = details
      @machine = machine
      @inventory = inventory
      @treasury = treasury
    end

    def execute
      if machine.transaction
        puts 'Please finish or abort current transaction'
      else
        transaction = machine.select_product(details&.capitalize)
        print_transaction_details(transaction)
      end
    rescue UnsupportedProductError => e
      puts e.message
    end

    private

    attr_reader :machine, :details

    def print_transaction_details(transaction)
      puts "You have selected #{transaction.product.name}"
      puts "Please pay #{transaction.remaining_payment}p to receive your merchandise"
    end
  end
end


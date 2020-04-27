module MarcusCommands
  class Insert
    VALUE_TO_DENOMINATION_MAP = {
      1 => '1p',
      2 => '2p',
      5 => '5p',
      10 => '10p',
      20 => '20p',
      50 => '50p',
      100 => '1£',
      200 => '2£'
    }.freeze

    def initialize(details, machine, _inventory, treasury)
      @details = details
      @machine = machine
      @treasury = treasury
    end

    def execute
      return print_no_transaction unless machine.transaction

      machine.insert_coin(details)

      if machine.transaction.paid_in_full?
        product = machine.transaction.product

        change_values = machine.transaction.calculate_change(treasury.coins)

        treasury.subtract_coins(change_values)

        machine.release_product(product.name)

        print_release_product(product.name)
        print_release_change(change_values)

        machine.clear_transaction
      else
        print_payment_due(machine.transaction.remaining_payment)
      end
    rescue InsufficientCoinsError => e
      puts e.message
    rescue UnsupportedCoinError => e
      puts e.message
    end

    private

    attr_reader :machine, :details, :treasury

    def print_no_transaction
      puts 'Please select product first'
    end

    def print_release_product(name)
      puts "Here is your #{name}. Enjoy and come around!"
    end

    def print_release_change(change_values)
      puts 'Here is your change:'

      change_values.each do |value|
        puts "#{VALUE_TO_DENOMINATION_MAP.fetch(value)}"
      end
    end

    def print_payment_due(remaining_payment)
      puts "Please pay #{remaining_payment}p more to receive your merchandise"
    end
  end
end

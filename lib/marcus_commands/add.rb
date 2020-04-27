module MarcusCommands
  class Add
    def initialize(details, machine, _inventory, _treasury)
      @details = details
      @machine = machine
    end

    def execute
      denomination, amount = details&.split(' ')

      machine.add_to_treasury(denomination, amount.to_i)

      print_coins_added
    rescue UnsupportedCoinError => e
      puts e.message
    end

    private

    attr_reader :machine, :details

    def print_coins_added
      puts 'Coins added to treasuery!'
    end
  end
end

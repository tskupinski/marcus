module MarcusCommands
  class Add
    def initialize(details, machine, _inventory, _treasury, printer)
      @details = details
      @machine = machine
      @printer = printer
    end

    def execute
      denomination, amount = details&.split(' ')

      machine.add_to_treasury(denomination, amount.to_i)

      printer.coins_added
    rescue UnsupportedCoinError => e
      printer.message(e.message)
    end

    private

    attr_reader :machine, :details, :printer
  end
end

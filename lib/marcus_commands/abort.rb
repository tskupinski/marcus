module MarcusCommands
  class Abort
    def initialize(_details, machine, _inventory, _treasury)
      @machine = machine
    end

    def execute
      machine.abort_transaction
      print_transaction_aborted
    end

    private

    attr_reader :machine

    def print_transaction_aborted
      puts 'Transaction aborted! Please pick up your coins!'
    end
  end
end

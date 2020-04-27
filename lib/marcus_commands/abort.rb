module MarcusCommands
  class Abort
    def initialize(_details, machine, _inventory, _treasury)
      @machine = machine
    end

    def execute
      if machine.transaction
        machine.clear_transaction
        print_transaction_aborted
      else
        print_no_transaction
      end
    end

    private

    attr_reader :machine

    def print_transaction_aborted
      puts 'Transaction aborted! Please pick up your coins!'
    end

    def print_no_transaction
      puts 'No transaction to abort'
    end
  end
end

module MarcusCommands
  class Abort
    def initialize(_details, machine, _inventory, _treasury, printer)
      @machine = machine
      @printer = printer
    end

    def execute
      if machine.transaction
        machine.clear_transaction
        printer.transaction_aborted
      else
        printer.no_transaction
      end
    end

    private

    attr_reader :machine, :printer
  end
end

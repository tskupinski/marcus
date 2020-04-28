module MarcusCommands
  class Help
    def initialize(_details, _machine, _inventory, _treasury, printer)
      @printer = printer
    end

    def execute
      printer.help
    end

    private

    attr_reader :printer
  end
end

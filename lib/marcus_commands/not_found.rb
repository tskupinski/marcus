module MarcusCommands
  class NotFound
    def initialize(_details, _machine, _inventory, _treasury, printer); end

    def execute
      puts 'Command not found - use help to review commands list'
    end
  end
end

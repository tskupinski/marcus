require_relative './machine'
require_relative './command_input'
require_relative './command_factory'
require_relative './printer'

class Marcus
  def initialize
    @treasury = Treasury.new
    @inventory = Inventory.new
    @machine = Machine.new(inventory, treasury)
    @printer = Printer.new
  end

  def start
    printer.hello

    printer.separator

    loop do
      user_input = STDIN.gets.chomp

      printer.separator

      execute_command(user_input)

      printer.separator

      printer.next_command_request
    end
  end

  private

  attr_reader :machine, :inventory, :treasury, :printer

  def execute_command(user_input)
    command_input = CommandInput.from_text(user_input)
    CommandFactory.build(command_input, machine, inventory, treasury, printer).execute
  end
end

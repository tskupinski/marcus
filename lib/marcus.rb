require_relative './machine'
require_relative './command_input'
require_relative './command_factory'
require_relative './printer'

class Marcus
  def initialize
    @treasury = Treasury.new
    @inventory = Inventory.new
    @printer = Printer.new
    @machine = Machine.new(inventory, treasury, printer)
  end

  def start
    say_hello
    print_separator

    loop do
      user_input = ask_for_input
      print_separator
      execute_command(user_input)
      print_separator
      ask_for_next_command
    end
  end

  private

  attr_reader :machine, :inventory, :treasury, :printer

  def say_hello
    printer.hello
  end

  def print_separator
    printer.separator
  end

  def ask_for_input
    STDIN.gets.chomp
  end

  def execute_command(user_input)
    command_input = CommandInput.from_text(user_input)
    CommandFactory.build(command_input, machine, inventory, treasury, printer).execute
  end

  def ask_for_next_command
    printer.next_command_request
  end
end

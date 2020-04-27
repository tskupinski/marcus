require_relative './machine'
require_relative './command_input'
require_relative './command_factory'

class Marcus
  def initialize
    @treasury = Treasury.new
    @inventory = Inventory.new
    @machine = Machine.new(inventory, treasury)
  end

  def start
    print_hello

    print_separator

    loop do
      command_input = CommandInput.from_text(STDIN.gets.chomp)

      print_separator

      execute_command(command_input)

      print_separator

      print_next_command_request
    end
  end

  private

  attr_reader :machine, :inventory, :treasury

  def execute_command(command_input)
    CommandFactory.build(command_input, machine, inventory, treasury).execute
  end

  def print_hello
    puts <<~HELLO
      This is a new day full of great opportunities!
      Welcome to vending machine, please type <help> to review avaliable commands
    HELLO
  end

  def print_separator
    puts '-----------------------------------------------'
  end

  def print_next_command_request
    puts 'Please provide your next command:'
  end
end

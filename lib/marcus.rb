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
    say_hello

    separator

    loop do
      text = STDIN.gets.chomp

      command_input = CommandInput.from_text(text)

      CommandFactory.build(command_input, machine, inventory, treasury).execute

      
      separator

     #  case input[0]
     #  when 'insert'
     #    insert_coin(input)
     #  when 'add'
     #    add_coins(input)
     #  when 'restock'
     #    restock_products(input)
     #  when 'help'
     #    display_help
     #  when 'exit'
     #    say_goodbye
     #    break
     #  end
     #
      separator
      next_command_please
    end
  end

  def insert_coin(input)
    return puts 'Please select product first' unless machine.transaction

    machine.insert_coin(input[1])

    if machine.transaction.paid_in_full?
      product = machine.transaction.product
      # TODO implement change
      # change = transaction.calculate_change

      machine.release_product(product.name)
      puts "Here is your #{product.name}. Enjoy and come around!"
    else
      puts "Please pay #{machine.transaction.remaining_payment}p more to receive your merchandise"
    end
  end

  def add_coins(input)
    denomination, amount = input[1]&.split(' ')

    machine.add_to_treasury(denomination, amount.to_i)

    puts 'Coins added to treasury!'
  end

  def restock_products(input)
    name, amount = input[1]&.split(' ')

    machine.restock_product(name, amount.to_i)

    puts 'Products added to machine inventory!'
  end













  def say_hello
    puts 'This is new day full of great opportunities!'
    puts 'Welcome to vending machine, please type help to review avaliable commands'
  end

  def display_help
    puts 'This is a content of help section (to be filled)'
  end

  def next_command_please
    puts 'Please provide your next command:'
  end

  def separator
    puts '-----------------------------------------------'
  end

  def say_goodbye
    puts "Dont't forget to come around!"
  end

  private

  attr_reader :machine, :inventory, :treasury
end

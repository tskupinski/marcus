require_relative './machine'

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

      input = text.strip.split(' ', 2)
      
      separator

      case input[0]
      when 'list'
        list_products
      when 'select'
        select_product(input)
      when 'abort'
        abort_transaction
      when 'insert'
        insert_coin(input)
      when 'add'
        add_coins(input)
      when 'restock'
        restock_products(input)
      when 'help'
        display_help
      when 'exit'
        say_goodbye
        break
      end

      separator
      next_command_please
    end
  end

  def list_products
    products = inventory.products

    products.each do |product|
      next if product.quantity <= 0

      puts "#{product.name} at a price of #{product.price_in_pounds}"
    end
  end

  def select_product(input)
    # TODO: Add rescue from error

    if machine.transaction
      puts 'Please finish or abort current transaction'
    else
      transaction = machine.select_product(input[1]&.capitalize)
      puts "You have selected #{transaction.product.name}"
      puts "Please pay #{transaction.remaining_payment}p to receive your merchandise"
    end
  end

  def abort_transaction
    machine.abort_transaction
    puts 'Transaction aborted! Please pick up your coins!'
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

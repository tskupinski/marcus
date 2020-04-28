class Printer
  def hello
    puts <<~HELLO
      This is a new day full of great opportunities!
      Welcome to vending machine, please type <help> to review avaliable commands
    HELLO
  end

  def separator
    puts '-----------------------------------------------'
  end

  def next_command_request
    puts 'Please provide your next command:'
  end

  def product_details(name, price_in_pounds, quantity)
    puts "#{name} at a price of #{price_in_pounds}, still #{quantity} in stock"
  end

  def transaction_aborted
    puts 'Transaction aborted! Please pick up your coins!'
  end

  def no_transaction
    puts 'No active transaction, please select product to start one'
  end

  def coins_added
    puts 'Coins added to treasuery!'
  end

  def message(message)
    puts message
  end

  def products_restocked
    puts 'Products added to machine inventory!'
  end

  def transaction_exists
    puts 'Please finish or abort current transaction'
  end

  def transaction_details(product_name, remaining_payment)
    puts "You have selected #{product_name}"
    puts "Please pay #{remaining_payment}p to receive your merchandise"
  end

  def payment_due(remaining_payment)
    puts "Please pay #{remaining_payment}p more to receive your merchandise"
  end

  def release_product(name)
    puts "Here is your #{name}. Enjoy and come around!"
  end

  def release_change(change_values)
    puts 'Please pick up your change'

    change_values.each do |value|
      puts value
    end
  end

  def help
    puts <<~HELP
      Thank you for browsing Marcus Merchandise.
      You can use following commands to interact with the machine:

      Customer commands:

      help - displays this document, if you are lost this is your command

      list - lists all avaliable products and their prices

      select <product name> - select product you wanna buy using the name from list e.g. select Mars

      insert <coin denomination> - after selecting the product insert coin to pay e.g. 10p
      after paying full price you will receive your product and change

      abort - aborts current transation so you can pick another product

      Maintainter commands:

      add <coin denomination> <amount> - adds coins to the machine, you need to provide supported
      supported coin denomination and amount e.g. add 10p 50

      restock <coin denomination> <amount> - restocks product in the machine, you need to provide
      product name and amount (WARNING: currently you can only restock products which are already
      offered by machine no new product types can be added) e.g. restock Mars 100
    HELP
  end
end

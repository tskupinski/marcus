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
end

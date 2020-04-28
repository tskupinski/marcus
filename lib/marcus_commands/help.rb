module MarcusCommands
  class Help
    def initialize(_details, _machine, _inventory, _treasury, printer); end

    def execute
      print_help
    end

    private

    def print_help
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
end

module MarcusCommands
  class List
    def initialize(_details, _machine, inventory, _treasury, printer)
      @inventory = inventory
      @printer = printer
    end

    def execute
      inventory.products.each do |product|
        next if product.quantity <= 0

        printer.product_details(product.name, product.price_in_pounds, product.quantity)
      end
    end

    private

    attr_reader :inventory, :printer
  end
end

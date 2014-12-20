class Cart < ActiveRecord::Base
    has_many :line_items, dependent: :destroy

    # Ein Produkt hinzufügen.
    #
    # @param {Product} das hinzugefügt werden soll. 
    #
    # @returns {LineItem} mit dem Produkt.
    def add_product(product)
        current_item = line_items.find_by(product_id: product.id)
        if current_item
            current_item.qty += 1
        else
            current_item = line_items.build(product_id: product.id, price: product.price)
        end
        current_item
    end
end

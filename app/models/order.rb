class Order < ActiveRecord::Base
    PAYMENT_TYPES = [ "Überweisung", "PayPal" ]
    SALUTATIONS = [ "Herr", "Frau" ]

    has_many :line_items, dependent: :destroy

    validates :firstname, :name, :street, :zip, :city, :country, :email, presence: true
    validates :pay_type, inclusion: PAYMENT_TYPES
    validates :salutation, inclusion: SALUTATIONS

    # Übernimmt alle Positionen aus dem Warenkorb in die Bestellung.
    def add_line_items_from_cart(cart) 
        cart.line_items.each do |item|
            item.cart_id = nil
            line_items << item
        end
    end
end

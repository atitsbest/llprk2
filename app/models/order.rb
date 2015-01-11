class Order < ActiveRecord::Base
    PAYMENT_TYPES = [ "Überweisung", "PayPal" ]
    SALUTATIONS = [ "Herr", "Frau" ]
    COUNTRIES = [ "de", "at", "ch" ]

    has_many :line_items, dependent: :destroy

    validates :firstname, :name, :street, :zip, :city, :country, :email, presence: true
    validates :pay_type, inclusion: PAYMENT_TYPES
    validates :salutation, inclusion: SALUTATIONS
    validates :country, inclusion: COUNTRIES

    # Auftragsnummer
    def order_number
        "#{created_at.day}#{created_at.month}#{created_at.year}"
    end

    # Gesamtpreis des Auftrags (exkl. Versand).
    def sub_total_price
        line_items.inject(0) {|sum, item| sum += item.price * item.qty} 
    end

    # Versandkosten.
    # TODO: Eine Order muss einmalig generiet werden, und wenn die Adresse
    #       geändert wird, muss auch die Order geändert werden.
    #       Eine (aus der DB) geladene Order kann nicht, nach einer geänderten
    #       Versandkostenberechnung, andere Kosten haben!
    def shipping_costs
        0
    end

    # Gesamtpreis des Auftrags (inkl. Versand).
    def total_price 
        sub_total_price + shipping_costs
    end

    # Übernimmt alle Positionen aus dem Warenkorb in die Bestellung.
    def add_line_items_from_cart(cart) 
        cart.line_items.each do |item|
            item.cart_id = nil
            line_items << item
        end
    end
end

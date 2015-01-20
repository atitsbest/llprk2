require 'securerandom'

class Order < ActiveRecord::Base
    PAYMENT_TYPES = [ 'wire', 'paypal' ]
    SALUTATIONS = [ "Herr", "Frau" ]

    has_many :line_items, dependent: :destroy
    belongs_to :country

    validates :order_number, :firstname, :name, :street, :zip, :city, :country_id, :email, :shipping_costs, :ip, presence: true
    validates :pay_type, inclusion: PAYMENT_TYPES
    validates :salutation, inclusion: SALUTATIONS
    validates :order_number, uniqueness: true

    # Gesamtpreis des Auftrags (exkl. Versand).
    def sub_total_price
        line_items.inject(0) {|sum, item| sum += item.price * item.qty}
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

    # Wurde mit PayPal gezahlt?
    def paypal?
        pay_type == 'paypal'
    end


    # Erstellt eine Bestellung aus einem Warenkorb.
    # Setzt dazu noch die Auftragsnummer.
    # Versandkosten müssen später gesetzt werden, weil zu diesem Zeitpunkt
    # noch keine Versandadresse (Land) angegeben wurde.
    def self.create_from_cart(cart)
        @order = Order.new
        @order.add_line_items_from_cart(cart)
        @order.order_number = OrderNumberService.create_order_number
        return @order
    end
end

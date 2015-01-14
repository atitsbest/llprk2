require 'securerandom'

class Order < ActiveRecord::Base
    PAYMENT_TYPES = [ "Überweisung", "PayPal" ]
    SALUTATIONS = [ "Herr", "Frau" ]

    has_many :line_items, dependent: :destroy
    belongs_to :country

    validates :order_number, :firstname, :name, :street, :zip, :city, :country_id, :email, :shipping_costs, presence: true
    validates :pay_type, inclusion: PAYMENT_TYPES
    validates :salutation, inclusion: SALUTATIONS

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
end

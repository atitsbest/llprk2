class Order < ActiveRecord::Base
    PAYMENT_TYPES = [ "Überweisung", "PayPal" ]

    validates :salutation, :firstname, :name, :street, :zip, :city, :country, :email, presence: true
    validates :pay_type, inclusion: PAYMENT_TYPES
end

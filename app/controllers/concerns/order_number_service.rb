require 'securerandom'

class OrderNumberService
    # Erstellt eine Bestellnummer für den aktuellen Tag.
    def self.create_order_number
        "#{Time.now.strftime('%y%m%d')}/#{SecureRandom.hex(2)}"
    end
end

class Country < ActiveRecord::Base
    has_many :orders

    # Sicherstellen, dass wir kein Land löschen, das bei einer
    # Adresse vorkommt.
    before_destroy :ensure_not_referenced_by_order

    private

    def ensure_not_referenced_by_order
        if orders.empty?
            return true
        else
            errors.add(:base, 'Order present')
            return false
        end
    end
end

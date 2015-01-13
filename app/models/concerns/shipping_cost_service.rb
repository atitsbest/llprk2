class ShippingCostService

    # Liefert die Versandkosten für eine Bestellung.
    def self.costs_for_order(order)
        result = 0.0
        base = 0.0

        # Für jedes Produkt die Versandkosten ermitteln.
        order.line_items.each do |li|
            cost = ShippingCost.find_by(
                country: order.country, 
                shipping_category: li.product.shipping_category)

            if cost != nil
                if cost.base > base
                    base = cost.base
                    base -= cost.additional
                end
                result += cost.additional * li.qty
            end
        end

        (result + base).to_f
    end
end

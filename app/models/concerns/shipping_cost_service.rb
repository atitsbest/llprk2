class ShippingCostService

    # Liefert die Versandkosten für eine Bestellung.
    def self.costs_for_order(order)
        self.costs_for_line_items(order.line_items, order.country_id)
    end

    # Berechnet die Versandkosten für ein Produkt in das angegebene Land.
    def self.costs_for_product(product, country_id, qty=1)
        result = 0
        base = 0
        cost = ShippingCost.find_by(
            country_id: country_id, 
            shipping_category: product.shipping_category)

        if cost != nil
            if cost.base > base
                base = cost.base
                base -= cost.additional
            end
            result += cost.additional * qty
        else
            # TODO: 
        end

        return (result + base).to_f
    end

    # Berechnet Versandkosten für LineItems in das angegebene Land.
    def self.costs_for_line_items(line_items, country_id)
        result = 0.0
        base = 0.0

        # Für jedes Produkt die Versandkosten ermitteln.
        line_items.each do |li|
            cost = ShippingCost.find_by(
                country_id: country_id, 
                shipping_category: li.product.shipping_category) || ShippingCost.first

            if cost != nil
                if cost.base > base
                    base = cost.base
                    base -= cost.additional
                end
                result += cost.additional * li.qty
            else
                # TODO:
            end
        end

        (result + base).round(2).to_f
    end
end

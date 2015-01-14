require 'test_helper'

class ShippingCostServiceTest < ActiveSupport::TestCase
    test "cost calculation for order" do
        costs = ShippingCostService.costs_for_order(orders(:one))
        assert_equal 4.5+2.5, costs

        # Leerer Warenkorb.
        costs = ShippingCostService.costs_for_order(orders(:no_line_items))
        assert_equal 0.0, costs

        costs = ShippingCostService.costs_for_order(orders(:two))
        assert_equal 4.5+(2*1.5), costs
    end

    test "cost calculation for line items and country" do
        order = orders(:one)
        costs = ShippingCostService.costs_for_line_items(order.line_items, 'at')
        assert_equal 4.5+2.5, costs

        # Leerer Warenkorb.
        order = orders(:no_line_items)
        costs = ShippingCostService.costs_for_line_items(order.line_items, 'at')
        assert_equal 0.0, costs

        order = orders(:two)
        costs = ShippingCostService.costs_for_line_items(order.line_items, 'at')
        assert_equal 4.5+(2*1.5), costs
      end
end


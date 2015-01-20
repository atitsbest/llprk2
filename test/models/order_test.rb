require 'test_helper'

class OrderTest < ActiveSupport::TestCase
    test "assign line items from cart" do
        cart = Cart.new
        cart.add_product(products(:soki))
        cart.add_product(products(:kalender))
        cart.save!

        sut = orders(:no_line_items)
        sut.add_line_items_from_cart(cart)
        sut.pay_type = :paypal
        sut.save!

        # Cart neu laden um Änderungen sichtbar zu machen.
        cart = Cart.find(cart.id)

        assert_equal(2, sut.line_items.length)
        assert_equal(0, cart.line_items.length)
    end

    test "create new order from cart" do
        cart = Cart.new
        cart.add_product(products(:soki))
        cart.add_product(products(:jacob))
        cart.save!

        sut = Order.create_from_cart(cart)

        assert_not_nil sut.order_number, "Keine Auftragsnummer vergeben."
        assert_equal 2, sut.line_items.length
    end

    test "calculates total price" do
        sut = orders(:one)

        assert_equal(95.00, sut.sub_total_price)
        assert_equal(7.00, sut.shipping_costs)
        assert_equal(102.00, sut.total_price)
    end

    test "is paypal?" do
        sut = Order.new(pay_type: 'paypal')
        assert sut.paypal?

        sut = Order.new(pay_type: 'wire')
        assert_not sut.paypal?
    end
end

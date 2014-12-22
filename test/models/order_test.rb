require 'test_helper'

class OrderTest < ActiveSupport::TestCase
    test "show assign line items from cart" do
        cart = Cart.new
        cart.add_product(products(:soki))
        cart.add_product(products(:kalender))
        cart.save!

        sut = orders(:no_line_items)
        sut.add_line_items_from_cart(cart)
        sut.save!

        # Cart neu laden um Änderungen sichtbar zu machen.
        cart = Cart.find(cart.id)

        assert_equal(2, sut.line_items.length)
        assert_equal(0, cart.line_items.length)
    end
end

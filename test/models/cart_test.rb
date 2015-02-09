require 'test_helper'

class CartTest < ActiveSupport::TestCase
    test "#add_product should add a product into an empty cart" do
        sut = Cart.create
        product = products(:soki)

        sut.add_product(product)

        assert_equal(1, sut.line_items.length)
        assert_equal(product.price, sut.line_items.first.price)
    end

    test "#add_product should inc quantity if product already in cart" do
        sut = Cart.create
        product = products(:soki)

        sut.add_product(product).save!
        assert_equal(1, sut.line_items.length)

        sut = Cart.find(sut.id)
        sut.add_product(product).save!
        assert_equal(1, sut.line_items.length)
        assert_equal(2, sut.line_items.first.qty)
    end

    test "add multiple products to cart" do
        sut = Cart.create
        product = products(:soki)

        sut.add_product(product, 3)

        assert_equal(1, sut.line_items.length)
        assert_equal(3, sut.line_items.first.qty)
    end

    test "should be empty if it has no line items" do
        sut = Cart.create 
        assert_equal(0, sut.line_items.length)
        assert(sut.empty?)

        product = products(:soki)
        sut.add_product(product).save!

        assert(!sut.empty?)
    end


end

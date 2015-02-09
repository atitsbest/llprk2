require 'test_helper'

class LineItemsControllerTest < ActionController::TestCase
    test "add product to cart" do
        assert_difference('LineItem.count') do
            post :create, product_id: products(:soki).id
        end

        assert_redirected_to cart_path
        assert_not_nil flash[:notice]
    end

    test "add multiple products to cart" do
        assert_difference('LineItem.count') do
            post :create, { product_id: products(:soki).id, qty: 3 }
        end

        assert_redirected_to cart_path
        assert_equal 3, Cart.last.line_items.first.qty
        assert_not_nil flash[:notice]
    end

    test "delete product from cart" do
        assert_difference('LineItem.count', -1) do
            delete :destroy, {id: line_items(:one).id}, { cart_id: 1 }
        end

        assert_redirected_to cart_path
    end
end

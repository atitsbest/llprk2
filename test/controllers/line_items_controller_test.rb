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

        assert_response :success
    end

    test 'update line_item quantity' do
        li = line_items(:one)
        patch :update, { id: li.id, qty: 13 }, format: 'json', cart_id: 1

        assert_response :success
        li = LineItem.find(li.id)
        assert_equal 13, li.qty
    end

end

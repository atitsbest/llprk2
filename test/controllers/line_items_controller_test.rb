require 'test_helper'

class LineItemsControllerTest < ActionController::TestCase
    test "should add product to cart" do
        assert_difference('LineItem.count') do
            post :create, product_id: products(:soki).id
        end

        assert_redirected_to cart_path(assigns(:line_item).cart)
        assert_not_nil flash[:notice]
    end
end

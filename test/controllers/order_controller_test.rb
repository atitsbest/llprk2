require 'test_helper'

class OrderControllerTest < ActionController::TestCase
    test "requires items in cart" do
        get :new
        assert_redirected_to store_path
        assert_not_nil flash[:notice]
    end

    test "should get new" do
        item = LineItem.new
        item.build_cart
        item.product = products(:soki)
        item.save!

        get :new, nil, { :cart_id => item.cart.id }

        assert_response :success
    end

end

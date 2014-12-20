require 'test_helper'

class CartControllerTest < ActionController::TestCase
    test "should show line items" do
        get :show, nil, {:cart_id => 1}

        assert_response :success

        assert_select "#line_items li", 2
    end
end

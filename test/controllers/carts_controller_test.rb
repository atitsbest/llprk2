require 'test_helper'

class CartsControllerTest < ActionController::TestCase
    test "show" do
        get :show, nil, {:cart_id => 1}

        assert_response :success
    end

    test "show json" do
        get :show, {format: :json}, {:cart_id => 1}

        assert_response :success
    end
end

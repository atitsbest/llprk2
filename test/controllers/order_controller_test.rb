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

    test "should create order" do
        assert_difference('Order.count') do
            post :create, order: {
                  salutation: 'Herr',
                  firstname: 'Stephan',
                  name: 'Meißner',
                  company: nil,
                  street: 'Teststrasse 11',
                  zip: '4711',
                  city: 'Testhausen',
                  country: 'at',
                  email: 'test@tester.test',
                  pay_type: 'PayPal'
            }
        end

        assert_redirected_to store_path
    end


end

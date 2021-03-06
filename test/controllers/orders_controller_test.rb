require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
    test "requires items in cart" do
        get :new
        assert_redirected_to store_path
        assert_not_nil flash[:notice]
    end

    test "should get new" do
        item = LineItem.new
        item.build_cart
        item.product = products(:soki)
        item.price = 9.99
        item.save!

        get :new, nil, { :cart_id => item.cart.id }

        assert_response :success
    end

    test "edit" do
        get :edit, id: orders(:one)

        assert_response :success
    end

    test "should create order" do
        assert_difference('Order.count') do
            post_create_wire_order
        end

        assert_redirected_to success_order_url
    end

    test "should create order number" do
        assert_difference('Order.count') do
            post_create_wire_order
        end

        assert_match(/^15\d{4}\/[0-9a-f]{4}$/, Order.last.order_number)
    end

    test "should calculate and save shipping costs" do
        assert_difference('Order.count') do
            post_create_wire_order
        end

        costs = ShippingCostService.costs_for_order(Order.last)
        assert_equal(costs, Order.last.shipping_costs)
    end

    test "should send confirmation mail to customer" do
        assert_difference('Order.count') do
            post_create_wire_order
        end

        assert_not ActionMailer::Base.deliveries.empty?, "Keine Bestätigungs-Mail versendet!"
    end

    test "continue to paypal" do
        Payment.delete_all # Damit ein Payment mit nil identifier erstellt werden kann.

        fake_paypal_response 'setup/success'
        post_create_order

        assert_response 302
    end

    test "show order confirmation" do
        post_create_wire_order

        assert_redirected_to success_order_url
    end

    test "should get success" do
        get :success
        assert_response :success
    end

    private
    def post_create_order
        post :create, order: {
              salutation: 'Herr',
              firstname: 'Stephan',
              name: 'Meißner',
              company: nil,
              street: 'Teststrasse 11',
              zip: '4711',
              city: 'Testhausen',
              country_id: 'at',
              email: 'test@tester.test',
              pay_type: 'paypal',
              accepted: true
        }
    end

    def post_create_wire_order
        post :create, order: {
              salutation: 'Herr',
              firstname: 'Stephan',
              name: 'Meißner',
              company: nil,
              street: 'Teststrasse 11',
              zip: '4711',
              city: 'Testhausen',
              country_id: 'at',
              email: 'test@tester.test',
              pay_type: 'wire',
              accepted: true
        }
    end
end

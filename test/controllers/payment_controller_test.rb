require 'test_helper'

class PaymentControllerTest < ActionController::TestCase
    test "should get success" do
        fake_paypal_response 'checkout/success'
        get :success, token: '345', PayerID: '1234'

        payment = Payment.find_by_token '345'
        assert_response :success
        assert payment.completed
    end

    test "show error message on checkout failure" do
        fake_paypal_response 'checkout/failure'
        get :success, token: '345', PayerID: '1234'

        assert_redirected_to new_order_url
        assert_not_nil flash[:error]
    end

    test "cancel" do
        get :cancel, token: '345'

        payment = Payment.find_by_token '345'
        assert payment.canceled
        assert !payment.completed
        assert_redirected_to edit_order_url(payment.order)
        assert_not_nil flash[:notice]
    end

    test "cancel completed payment" do
        get :cancel, token: '456'

        assert_redirected_to store_url
        assert_not_nil flash[:error]
    end

end

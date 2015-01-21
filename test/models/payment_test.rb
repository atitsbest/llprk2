require 'test_helper'

class PaymentTest < ActiveSupport::TestCase
    test "token is unique" do
        sut = Payment.new(token: '123', amount: 100)
        assert_raises(ActiveRecord::RecordInvalid) { sut.save! }
    end

    test "identifier is unique" do
        sut = Payment.new(identifier: 'xyz', amount: 100)
        assert_raises(ActiveRecord::RecordInvalid) { sut.save! }
    end

    test "cancel" do
        sut = payments(:incomplete)
        assert(!sut.canceled)

        sut.cancel!

        assert(sut.canceled)
    end

    test "complete" do
        sut = payments(:incomplete)

        fake_paypal_response 'setup/success'
        sut.setup! 'http://localhost', 'http://localhost'

        assert_not_nil sut.token
        assert !sut.completed
        assert !sut.canceled

        fake_paypal_response 'checkout/success'
        sut.complete! "payer_id"

        assert sut.completed
        assert !sut.canceled
        assert_equal "payer_id", sut.payer_id
        assert_not_nil sut.identifier
    end

    test "complete with checkout error" do
        sut = payments(:incomplete)

        fake_paypal_response 'setup/success'
        sut.setup! 'http://localhost', 'http://localhost'

        assert_not_nil sut.token
        assert !sut.completed
        assert !sut.canceled

        begin
            fake_paypal_response 'checkout/failure'
            sut.complete! "payer_id"
        rescue
        end

        assert !sut.completed
        assert !sut.canceled
        assert_nil sut.payer_id
        assert_nil sut.identifier
    end

    test "complete completed payment" do
        sut = payments(:complete)

        assert_raises(Exception) { sut.complete! }
    end

end

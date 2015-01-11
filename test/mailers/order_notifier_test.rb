require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  test "received" do
    mail = OrderNotifier.received(orders(:one))

    assert_equal "Vielen Dank für Ihre Bestellung.", mail.subject
    assert_equal ["customer@tester.test"], mail.to
    assert_equal ["test@tester.test"], mail.from
    assert_equal read_fixture('received').join, mail.text_part.body.decoded
  end

  test "paid" do
    mail = OrderNotifier.paid(orders(:one))
    assert_equal "Wir haben Ihre Bezahlung erhalten.", mail.subject
    assert_equal ["customer@tester.test"], mail.to
    assert_equal ["test@tester.test"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "shipped" do
    mail = OrderNotifier.shipped(orders(:one))
    assert_equal "Ihre Bestellung wurde verschickt.", mail.subject
    assert_equal ["customer@tester.test"], mail.to
    assert_equal ["test@tester.test"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end

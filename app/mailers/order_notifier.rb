class OrderNotifier < ApplicationMailer
    default from: 'Sam Tester <test@tester.test>'

    # Subject can be set in your I18n file at config/locales/en.yml
    # with the following lookup:
    #
    #   en.order_notifier.received.subject
    #
    def received(order)
        @order = order

        mail to: @order.email
    end

    # Subject can be set in your I18n file at config/locales/en.yml
    # with the following lookup:
    #
    #   en.order_notifier.paid.subject
    #
    def paid(order)
        @order = order

        mail to: order.email
    end

    # Subject can be set in your I18n file at config/locales/en.yml
    # with the following lookup:
    #
    #   en.order_notifier.shipped.subject
    #
    def shipped(order)
        @order = order

        mail to: order.email
    end
end

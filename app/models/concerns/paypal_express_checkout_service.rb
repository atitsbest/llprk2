class PaypalExpressCheckoutService
    # Schließt eine Bezahlung ab und speichert die
    # Informationen dazu in der Bestellung (order) ab.
    #
    # @param order
    # @param token
    # @param payer_id
    # @param id
    #
    # @returns success?
    def self.purchase_order(order, token, payer_id)
        request = PayPal::Express::Request.new(
            :username => '',
            :password => '',
            :signature => ''
        )

        response = request.checkout!(
            token,
            payer_id
        )

        true


        # response = EXPRESS_GATEWAY.purchase(order.total_price.to_cents, {
        #     :ip => order.ip,
        #     :token => token,
        #     :payer_id => payer_id
        # })
        #
        # response.success?
    end

    # Bereitet einen Express-Checkout vor.
    #
    # @param order
    # @param return_url
    # @param cancel_url
    #
    # @returns Redirect to to PayPal.
    def self.setup_purchase(order, return_url, cancel_url)
        paypal_options = {}

        response = request.setup(
            payment_request,
            return_url,
            cancel_url,
            paypal_options
        )

        response.redirect_url

        # shipping_costs = ShippingCostService.costs_for_line_items(order.line_items, 'at')
        #
        # response = EXPRESS_GATEWAY.setup_purchase((order.sub_total_price + shipping_costs).to_cents,
        #     ip: order.ip,
        #     return_url: return_url,
        #     cancel_return_url: cancel_url,
        #     currency: "EUR",
        #     allow_guest_checkout: true,
        #     items: order.line_items.map do |item|
        #         {
        #             name: item.product.title,
        #             description: nil,
        #             quantity: item.qty.to_s,
        #             amount: item.price.to_cents } # TODO: * Qty?
        #     end)
        #
        # return EXPRESS_GATEWAY.redirect_url_for(response.token)
    end

end


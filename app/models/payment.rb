class Payment < ActiveRecord::Base
    belongs_to :order

    validates :token, uniqueness: true
    validates :amount, :order_id, presence: true
    validates :identifier, uniqueness: true

    attr_reader :redirect_url

    def setup!(return_url, cancel_url)
        response = client.setup(
            payment_request,
            return_url,
            cancel_url,
            pay_on_paypal: true,
            no_shipping: false
        )

        self.token = response.token
        self.save!

        @redirect_url = response.redirect_uri
        self
    end

    def cancel!
        raise Exception.new("Payment bereits abgeschlossen!") if completed

        self.canceled = true
        self.save!
        self
    end

    def complete!(payer_id = nil)
        raise Exception.new("Payment bereits abgeschlossen!") if completed

        response = client.checkout!(self.token, payer_id, payment_request)
        self.payer_id = payer_id
        self.identifier = response.payment_info.first.transaction_id
        self.completed = true
        self.save!
        self
    end

    private

    def client
        Paypal::Express::Request.new({
            username: 'merchant_api1.llprk.dev',
            password: 'KEJHC7YCJFZMJUJJ',
            signature: 'AFcWxV21C7fd0v3bYYYRCpSSRl31AAu1-B79YKOzS2hITWcaTPGzS5-I',
            sandbox:   true
        })
    end

    def payment_request
        request_attributes = {
            currency_code: :EUR,
            amount: self.amount,
            shipping_amount: order.shipping_costs,
            invoice_number: order.order_number,
            items: order.line_items.map do |item|
            {
                name: item.product.title,
                quantity: item.qty,
                amount: item.price,
                currency: "EUR" }
            end,
            :custom_fields => {
                LOGOIMG: "http://lillypark.com/images/syl-small.png"
            }
        }
        Paypal::Payment::Request.new request_attributes
    end
end

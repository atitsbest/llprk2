class OrderController < ApplicationController
    include CurrentCart
    before_action :set_cart

    # Seite: Bestellübersicht.
    def new
        if @cart.empty?
            redirect_to store_url, notice: 'Der Warnkorb ist leer!'
            return
        end

        @order = Order.new
    end

    # Bestellung wird aufgegeben.
    def create
        @order = create_order_from_cart(@cart)
        @order.ip = request.remote_ip

        respond_to do |format|
            if @order.save
                # Warenkorb kann mit vollendeter Bestellung gelöscht werden.
                Cart.destroy(session[:cart_id])
                session[:cart_id] = nil

                # Bestätigungs-Mail verschicken.
                OrderNotifier.received(@order).deliver_later

                # Falls mit Paypal gezahlt werden soll, bereiten wir
                # das Bezahlen vor und leiten weiter zu PayPal.
                if @order.paypal?
                    payment = Payment.create!(amount: @order.total_price, order: @order)
                    payment.setup!(
                        order_create_express_url(@order),
                        order_new_url
                    )
                    format.html { redirect_to payment.redirect_url }
                else
                    # Wenn kein PayPal, dann sagen wir Danke.
                    format.html { redirect_to store_url, notice: 'Vielen Dank für Ihre Bestellung.' }
                end
            else
                format.html { render action: 'new' }
            end
        end
    end

    def express_create
        @order = Order.find(params[:id])

        respond_to do |format|
            if PaypalExpressCheckoutService.purchase_order(@order, params[:token], params[:PayerID])
                format.html { redirect_to store_url,
                              notice: 'Vielen Dank für Ihre Bestellung. Wir haben Ihre Bezahlung erhalten.' }
            else
                format.html { redirect_to order_new_url, 
                              notice: 'Beim Bezahlen mit PayPal ist ein Fehler passiert!' }
            end
        end
    end

    # Paypal-Express-Checkout wird gestartet.
    def express
        paypal_url = PaypalExpressCheckoutService.setup_purchase(@cart, remote_ip)
        redirect_to paypal_url
    end


    private

    def order_params
        params.require(:order).permit(:salutation, :firstname, :name, :company, :street, :zip, :city, :country_id, :email, :pay_type)
    end

    def create_order_from_cart(cart)
        order = Order.create_from_cart(cart)
        order.update(order_params)
        order.shipping_costs = ShippingCostService.costs_for_order(order)

        order
    end

end

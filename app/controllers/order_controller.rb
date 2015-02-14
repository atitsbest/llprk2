class OrderController < ApplicationController
    include CurrentCart
    before_action :set_cart

    # Seite: Bestellübersicht.
    def new
        if @cart.empty?
            redirect_to store_url, notice: 'Der Warnkorb ist leer!'
            return
        end

        # Liste aller Länder mit den Versandkosten.
        @shipping_costs = {}
        Country.all.each do |c|
            @shipping_costs[c.id] = ShippingCostService.costs_for_line_items(@cart.line_items, c.id)
        end

        @countries = Country.all.map do |c|
            costs = @shipping_costs[c.id]
            [ c.id,
              "#{c.name} (Versand: #{ActionController::Base.helpers.number_to_currency costs})"
            ]
        end
        @order = Order.new
    end

    # Offene Bestellung wird angezeigt.
    def edit
        @order = Order.find_by_id!(params[:id])

        respond_to do |format|
            format.html { render :new }
        end
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
                    payment = Payment.new(amount: @order.total_price, order: @order)
                    payment.setup!(
                        payment_success_url,
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

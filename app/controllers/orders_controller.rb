class OrdersController < ApplicationController
    include CurrentCart
    before_action :set_cart

    # Seite: Bestellübersicht.
    def new
        if @cart.empty?
            redirect_to store_url, notice: 'Der Warnkorb ist leer!'
            return
        end

        prepare_shipping_costs

        @order = Order.new
    end

    # Offene Bestellung wird angezeigt.
    def edit
        @order = Order.find_by_id!(params[:id])
        prepare_shipping_costs

        respond_to do |format|
            format.html { render :new }
        end
    end

    # Bestellung wird aufgegeben.
    def create
        @order = create_order_from_cart(@cart)
        @order.ip = request.remote_ip
        byebug
        @order.accepted = (params[:order][:accepted] == '1')

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
                        new_order_url
                    )
                    format.html { redirect_to payment.redirect_url }
                else
                    # Wenn kein PayPal, dann sagen wir Danke.
                    format.html { redirect_to success_order_url, notice: 'Vielen Dank für Ihre Bestellung.' }
                end
            else
                prepare_shipping_costs
                format.html { render action: 'new' }
            end
        end
    end

    # Wenn die Bestellung erfolgreich aufgegeben wurde.
    def success
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

    # Alle Länder mit Versandkosten versehen.
    # Hilfsmethode für new und create.
    def prepare_shipping_costs
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

    end

end

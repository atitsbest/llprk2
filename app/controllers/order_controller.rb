class OrderController < ApplicationController
    include CurrentCart
    before_action :set_cart, only: [:new, :create]

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
        @order = Order.new(:order_number => OrderNumberService.create_order_number)
        @order.update(order_params)
        @order.add_line_items_from_cart(@cart)

        respond_to do |format|
            if @order.save
                Cart.destroy(session[:cart_id])
                session[:cart_id] = nil

                format.html { redirect_to store_url, notice: 'Vielen Dank für Ihre Bestellung.' }
            else
                format.html { render action: 'new' }
            end
        end
    end

    private

    def order_params
        params.require(:order).permit(:salutation, :firstname, :name, :company, :street, :zip, :city, :country, :email, :pay_type)
    end

end

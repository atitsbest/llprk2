class OrderController < ApplicationController
    include CurrentCart
    before_action :set_cart, only: [:new, :create]

    def new
        if @cart.empty?
            redirect_to store_url, notice: 'Der Warnkorb ist leer!'
            return
        end

        @order = Order.new
    end

    def create
    end
end

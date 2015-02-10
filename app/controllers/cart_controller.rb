class CartController < ApplicationController
    include CurrentCart
    before_action :set_cart

    # Zeigt den Warenkorb an.
    def show
    end

end

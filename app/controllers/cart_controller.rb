class CartController < ApplicationController
    include CurrentCart
    before_action :set_cart
    rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

    # Zeigt den Warenkorb an.
    def show
        # @cart wird schon in set_cart geladen.
    end
end

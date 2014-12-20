class StoreController < ApplicationController

    # Zeigt alle Produkte an.
    def index
        @products = Product.order(:title)
    end

    # Zeigt ein einzelnes Produkt an.
    def products
        @product = Product.find(params[:id])
    end


end

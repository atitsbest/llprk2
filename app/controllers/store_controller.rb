class StoreController < ApplicationController

    # Zeigt alle Produkte an.
    def index
        @products = Product.includes(:images).order(:created_at).take(50)
    end

    # Zeigt ein einzelnes Produkt an.
    def products
        @product = Product.includes(:images).find(params[:id])
        @products = []

        # Cross-Selling: derzeit noch zufällig.
        6.times do
            offset = rand(Product.count)
            @products << Product.includes(:images).offset(offset).first
        end
    end


end

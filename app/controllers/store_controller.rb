class StoreController < ApplicationController

    # Zeigt alle Produkte an.
    def index
        @products = Product.order(:title)
    end

    # Zeigt ein einzelnes Produkt an.
    def products
        @product = Product.find(params[:id])
        @products = []
        
        # Cross-Selling: derzeit noch zufällig.
        6.times do 
            offset = rand(Product.count)
            @products << Product.offset(offset).first
        end
    end


end

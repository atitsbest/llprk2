class LineItemsController < ApplicationController
    include CurrentCart
    before_action :set_cart, only: [:create]

    # Wenn ein Produkt in den Warenkorb gelegt wird.
    def create
        product = Product.find(params[:product_id])
        @line_item = @cart.add_product(product)

        respond_to do |format|
            if @line_item.save
                format.html { redirect_to @line_item.cart,
                              notice: "#{product.title} wurde in Deinen Warenkorb gelegt." }
            else
                format.html { render action: 'new' }
            end
        end
    end
end

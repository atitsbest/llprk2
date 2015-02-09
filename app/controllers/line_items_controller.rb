class LineItemsController < ApplicationController
    include CurrentCart
    before_action :set_cart

    # Wenn ein Produkt in den Warenkorb gelegt wird.
    def create
        product = Product.find(params[:product_id])
        qty = (params[:qty] || '1').to_i
        @line_item = @cart.add_product(product, qty)

        respond_to do |format|
            if @line_item.save
                format.html { redirect_to cart_url,
                              notice: "#{product.title} wurde in Deinen Warenkorb gelegt." }
            else
                format.html { render action: 'new' }
            end
        end
    end

    # Eine Bestellzeile komplet aus dem Warenkorb entfernen.
    def destroy
        li = @cart.line_items.find_by_id!(params[:id])
        li.destroy
        respond_to do |format|
            format.html { redirect_to cart_url, notice: 'Produkt wurde aus Deinem Warenkorb entfernt.' }
        end
    end
end

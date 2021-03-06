class Admin::ProductsController < AdminController
    before_action :set_product, only: [:show, :edit, :update, :destroy]

    # GET /products
    # GET /products.json
    def index
        respond_to do |format|
            format.html
            format.json do
                ps = Product.all
                ps = ps.where('lower(title) like ?', "%#{params[:query].downcase}%") if params[:query]
                @products = to_source(ps, params)
            end
        end
    end

    # GET /products/1
    # GET /products/1.json
    def show
    end

    # GET /products/new
    def new
        @product = Product.new
    end

    # GET /products/1/edit
    def edit
    end

    # POST /products
    # POST /products.json
    def create
        @product = Product.new(product_params)

        respond_to do |format|
            ActiveRecord::Base.transaction do
                if @product.save
                    # Produktbilder hinzufügen.
                    (params[:product][:new_images] || []).each do |image|
                        @product.images.create(content: image)
                    end

                    format.html { redirect_to admin_product_url(@product), notice: 'Product was successfully created.' }
                    format.json { render :show, status: :created, location: @product }
                else
                    format.html { render :new }
                    format.json { render json: @product.errors, status: :unprocessable_entity }
                end
            end # transaction
        end
    end

    # PATCH/PUT /products/1
    # PATCH/PUT /products/1.json
    def update
        @product.images.each do |image|
            # Entfernte Bilder auch in der DB löschen.
            if params[:product][:images].include? "id" => image.id.to_s
                # Position neu setzen.
                image.pos = params[:product][:images].index("id" => image.id.to_s)
            elsif
                image.destroy
            end
        end

        # Produktbilder hinzufügen.
        (params[:product][:new_images] || []).each do |image|
            @product.images.create(content: image)
        end

        respond_to do |format|
            if @product.update(product_params)
                format.html { redirect_to admin_products_url, notice: 'Product was successfully updated.' }
                format.json { render :show, status: :ok, location: @product }
            else
                format.html { render :edit }
                format.json { render json: @product.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /products/1
    # DELETE /products/1.json
    def destroy
        @product.destroy
        respond_to do |format|
            format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
        @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
        params.require(:product).permit(:title, :description, :price)
    end
end

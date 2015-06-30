require 'test_helper'

class Admin::ProductsControllerTest < ActionController::TestCase
    setup do
        @product = products(:soki)
    end

    test "should get index" do
        get :index
        assert_response :success
        # assert_not_nil assigns(:products)
    end

    test "should get new" do
        get :new
        assert_response :success
    end

    test "should create product" do
        assert_differences([['Product.count', 1], ['ProductImage.count', 2]]) do
            post :create, product: {
                description: @product.description,
                price: @product.price,
                title: @product.title + '_test',
                new_images: [
                    fixture_file_upload('files/product.png', 'image/png'),
                    fixture_file_upload('files/product.png', 'image/png')
                ]
            }
        end

        assert_redirected_to admin_product_path(assigns(:product))
    end

    test "should show product" do
        get :show, id: @product
        assert_response :success
    end

    test "should get edit" do
        get :edit, id: @product
        assert_response :success
    end

    test "should update product without image(s)" do
        patch :update, id: @product, product: {
            description: @product.description,
            price: @product.price,
            title: @product.title
        }
        assert_redirected_to admin_product_path(assigns(:product))
    end

    test "should update product with new images" do
        assert_difference('ProductImage.count', 2) do
            patch :update, id: @product, product: {
                description: @product.description,
                price: @product.price,
                title: @product.title,
                new_images: [
                    fixture_file_upload('files/product.png', 'image/png'),
                    fixture_file_upload('files/product.png', 'image/png')
                ]
            }
        end

        assert_redirected_to admin_product_path(assigns(:product))
    end

    test "reorder images" do
        patch :update, id: @product, product: {
            description: @product.description,
            price: @product.price,
            title: @product.title,
            new_images: [
                fixture_file_upload('files/product.png', 'image/png'),
                fixture_file_upload('files/product.png', 'image/png')
            ]
        }
        assert_nil @product.images.first.pos
        assert_nil @product.images.last.pos
        assert_equal 2, @product.images.length

        first_id = @product.images.first.id
        last_id = @product.images.last.id

        patch :update, id: @product, product: {
            description: @product.description,
            price: @product.price,
            title: @product.title,
            images: [
                { "id" => @product.images.last.id.to_s },
                { "id" => @product.images.first.id.to_s }
            ]
        }

        assert ProductImage.find(first_id).pos > ProductImage.find(last_id).pos, "Bilder wurde nicht neu angeordnet."
        assert_redirected_to admin_product_path(assigns(:product))
    end

    # test "should destroy product" do
    #   assert_difference('Product.count', -1) do
    #     delete :destroy, id: @product
    #   end
    #
    #   assert_redirected_to products_path
    # end
end

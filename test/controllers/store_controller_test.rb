require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  setup do
    @product = products(:soki)
  end

  test "should get index" do
    get :index
    assert_response :success

    assert_select '#products .product', 3
  end

  test "should get details" do
      get :products, :id => @product
      
      assert_response :success
  end

end

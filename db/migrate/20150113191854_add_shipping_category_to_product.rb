class AddShippingCategoryToProduct < ActiveRecord::Migration
  def change
      add_reference :products, :shipping_category
  end
end

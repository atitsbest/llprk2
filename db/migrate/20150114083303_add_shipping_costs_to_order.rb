class AddShippingCostsToOrder < ActiveRecord::Migration
  def change
      add_column :orders, :shipping_costs, :decimal, default: 0.0
  end
end

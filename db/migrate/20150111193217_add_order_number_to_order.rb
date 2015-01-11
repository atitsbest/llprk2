class AddOrderNumberToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :order_number, :string, :null => false
  end
end

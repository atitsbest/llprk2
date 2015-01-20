class AddPaypalToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :ip, :string, null: false
    add_column :orders, :paypal_token, :string
    add_column :orders, :paypal_payer_id, :string
  end
end

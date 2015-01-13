class CreateShippingCosts < ActiveRecord::Migration
  def change
    create_table :shipping_costs do |t|
      t.string :country_id, index: true 
      t.belongs_to :shipping_category, index: true
      t.decimal :base
      t.decimal :additional

      t.timestamps null: false
    end
    add_foreign_key :shipping_costs, :countries
    add_foreign_key :shipping_costs, :shipping_categories
  end
end

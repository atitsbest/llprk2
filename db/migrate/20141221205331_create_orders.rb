class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :salutation
      t.string :firstname
      t.string :name
      t.string :company
      t.string :street
      t.string :zip
      t.string :city
      t.string :country
      t.string :email
      t.string :pay_type

      t.timestamps
    end
  end
end

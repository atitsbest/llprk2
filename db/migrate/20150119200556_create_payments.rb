class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.belongs_to :order
      t.decimal :amount
      t.string :token
      t.string :identifier
      t.string :payer_id
      t.boolean :completed, default: false
      t.boolean :canceled, default: false

      t.timestamps null: false
    end
  end
end

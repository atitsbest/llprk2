class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
      t.references :product, index: true
      t.belongs_to :cart, index: true
      t.decimal :price

      t.timestamps
    end
  end
end

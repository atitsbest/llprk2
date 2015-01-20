class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :title
      t.text :description
      t.string :image_url
      t.decimal :price

      t.timestamps
    end

    reversible do |dir|
        dir.up do
            Product.create title: 'Jacob', description: 'Das ist ein Test', price: 45.90
        end
    end
  end
end

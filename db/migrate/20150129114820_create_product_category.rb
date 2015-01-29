class CreateProductCategory < ActiveRecord::Migration
  def change
    create_table :categories do |t|
        t.string :name
        t.timestamps null: false
    end

    create_table :categories_products do |t|
        t.belongs_to :product, index: true
        t.belongs_to :category, index: true
    end
  end
end

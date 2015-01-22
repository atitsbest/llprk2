class CreateProductImages < ActiveRecord::Migration
    def change
        create_table :product_images do |t|
            t.attachment :content
            t.integer :pos
            t.belongs_to :product

            t.timestamps null: false
        end
    end
end

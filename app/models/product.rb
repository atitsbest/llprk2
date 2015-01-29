class Product < ActiveRecord::Base
    has_many :line_items
    has_many :images, -> { order 'pos ASC' }, class_name: :ProductImage, dependent: :destroy
    belongs_to :shipping_category
    has_and_belongs_to_many :categories

    validates :title, :description, presence: true
    validates :price, numericality: {greater_than_or_equal_to: 0.01}
    # validates :title, uniqueness: true

    accepts_nested_attributes_for :images

    # Sicherstellen, dass wir keine Produkte löschen, die gerade in
    # jemandems Warenkorb liegen.
    before_destroy :ensure_not_referenced_by_any_line_item

    # Get last updates product.
    def self.latest
        Product.order(:updated_at).last
    end

    private

    def ensure_not_referenced_by_any_line_item
        if line_items.empty?
            return true
        else
            errors.add(:base, 'Line Items present')
            return false
        end
    end
end

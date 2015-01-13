class ShippingCost < ActiveRecord::Base
  belongs_to :country
  belongs_to :shipping_category
end

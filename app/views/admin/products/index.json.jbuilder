json.(@products, :orderBy, :count, :page, :total)
json.data @products[:data] do |product|
  json.extract! product, :id, :title, :description, :price
  json.url admin_product_url(product, format: :json)
  json.image_url product.images.first.content.url(:thumbnail)
end

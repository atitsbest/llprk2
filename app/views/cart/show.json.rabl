object @cart

child :line_items do
    attributes :id, :qty, :price

    child :product do
        attributes :title, :price
        node(:url) { |product| store_products_url(product) }

        child :images do
            node(:url) { |image| image.content(:gallery) }
        end
    end
end

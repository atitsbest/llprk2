object @cart

child :line_items do
    attributes :id, :qty
    node(:price) { |li| li.price.round(2).to_f }

    child :product do
        attributes :title
        node(:url) { |product| store_products_url(product) }

        child :images do
            node(:url) { |image| image.content(:gallery) }
        end
    end
end

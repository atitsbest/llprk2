# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Dir[
    File.join(Rails.root, "lib", "paperclip", "*.rb")
].each {|l| require l }

puts "Mit alter llprk-DB verbinden..."
puts Rails.application.secrets.old_connectionstring
client=TinyTds::Client.new(Rails.application.secrets.old_connectionstring.symbolize_keys)

# Speichert die Zuordnung von alter Produkt-Id und neuer Produkt-Id.
pp_ids = {}

ActiveRecord::Base.transaction do

    # Produkte laden.
    products = client.execute('select * from products')
    products.each do |p|
        puts p["Name"]
        product = Product.create!({
            title: p["Name"],
            description: p["Description"],
            price: [p["Price"], 0.01].max,
            created_at: p["CreatedAt"],
            updated_at: DateTime.now
        })

        pp_ids[p["Id"]] = product.id
    end

    # Bilder zu Produkten laden.
    pps = client.execute("select * from product_picture")
    pps.each do |pp|
        ppId = pp["PictureId"].downcase
        puts "Bild #{ppId} bei #{pp["Pos"]}"
        begin
            ProductImage.create!({
                product_id: pp_ids[pp["ProductId"]],
                content: URI.parse("http://llprk2.blob.core.windows.net/pictures/#{ppId}.png"),
                content_content_type: "image/png",
                pos: pp["Pos"],
                created_at: pp["CreatedAt"],
                updated_at: DateTime.now
            })
        rescue ActiveRecord::RecordInvalid
        end
    end

end

namespace :db do
  desc "Load products from products.json"
  task load_products: :environment do
    file = File.read(Rails.root.join('db', 'products.json'))
    products = JSON.parse(file)
    products.each do |product|
      Product.create(uuid: product['uuid'], name: product['name'], price: product['price'])
    end
  end
end

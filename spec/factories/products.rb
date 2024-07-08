FactoryBot.define do
  factory :product do
    uuid { Faker::Number.unique.number(digits: 4) }
    name { Faker::Commerce.product_name }
    price { Faker::Commerce.price(range: 0..100.0) }
  end
end

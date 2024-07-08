FactoryBot.define do
  factory :cart do
    association :user
    association :promotion
    subtotal { 0.0 }
    discount { 0.0 }
    total { 0.0 }
    items_count { 0 }
  end
end

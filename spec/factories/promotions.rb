FactoryBot.define do
  factory :promotion do
    threshold { Faker::Number.between(from: 20, to: 100) }
    discount { Faker::Number.decimal(l_digits: 0, r_digits: 2) }
  end
end
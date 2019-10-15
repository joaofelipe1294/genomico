FactoryBot.define do
  factory :reagent do
    product_description { Faker::Games::Zelda.character }
    name { Faker::Games::Zelda.item }
    stock_itens { 0 }
    usage_per_test { 0 }
    brand { create(:brand) }
    total_aviable { 1 }
    field { Field.IMUNOFENO }
    first_warn_at { Faker::Number.number(digits: 3) }
    danger_warn_at { Faker::Number.number(digits: 3) }
    product_code { Faker::Number.number(digits: 5).to_s }
    mv_code { Faker::Number.number(digits: 5).to_s }
  end
end

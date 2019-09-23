FactoryBot.define do
  factory :reagent do
    product_description { "MyString" }
    name { "MyString" }
    stock_itens { 1 }
    usage_per_test { 1 }
    brand { "MyString" }
    total_aviable { 1 }
    field { nil }
    first_warn_at { 1 }
    danger_warn_at { 1 }
  end
end

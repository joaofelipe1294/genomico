FactoryBot.define do
  factory :stock_product do
    name { "MyString" }
    usage_per_test { 1 }
    total_aviable { 1 }
    first_warn_at { 1 }
    danger_warn_at { 1 }
    mv_code { "MyString" }
    unit_of_measurement { nil }
    field { nil }
    is_shared { false }
  end
end

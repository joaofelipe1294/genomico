FactoryBot.define do
  factory :stock_product do
    name { Faker::Name.name }
    first_warn_at { nil }
    danger_warn_at { nil }
    mv_code { Faker::Code.isbn }
    unit_of_measurement { :boxes }
    field { Field.all.sample }
    is_shared { false }
  end
end

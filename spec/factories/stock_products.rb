FactoryBot.define do
  factory :stock_product do
    name { Faker::Name.name }
    usage_per_test { nil }
    total_aviable { 0 }
    first_warn_at { nil }
    danger_warn_at { nil }
    mv_code { "e2tv23" }
    unit_of_measurement { UnitOfMeasurement.all.sample }
    field { Field.all.sample }
    is_shared { false }
  end
end

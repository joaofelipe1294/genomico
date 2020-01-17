FactoryBot.define do
  factory :stock_product do
    name { Faker::Name.name }
    total_aviable { 0 }
    first_warn_at { nil }
    danger_warn_at { nil }
    mv_code { Faker::Code.isbn }
    unit_of_measurement { UnitOfMeasurement.all.sample }
    field { Field.all.sample }
    is_shared { false }
    total_in_use { 0 }
  end
end

FactoryBot.define do
  factory :sample do
    sample_kind { create(:sample_kind) }
    has_subsample { Faker::Boolean.boolean }
    entry_date { Faker::Date.between(from: 22.days.ago, to: Date.today) }
    collection_date { Faker::Date.between(from: 30.days.ago, to: Date.today) }
    refference_label { nil }
    bottles_number { Faker::Number.number(digits: 1) }
    storage_location { Faker::Lorem.sentences(number: 1) }
  end
end

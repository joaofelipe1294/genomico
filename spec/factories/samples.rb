FactoryBot.define do
  factory :sample do
    sample_kind { create(:sample_kind) }
    has_subsample { Faker::Boolean.boolean }
    entry_date { Faker::Date.between(22.days.ago, Date.today) }
    collection_date { Faker::Date.between(30.days.ago, Date.today) }
    refference_label { nil }
    bottles_number { Faker::Number.number(1) }
    storage_location { Faker::Lorem.sentences(1) }
  end
end

FactoryBot.define do
  factory :subsample do
    storage_location { Faker::Lorem.sentence(3) }
    sample { create(:sample) }
    collection_date { Faker::Date.between(21.days.ago, Date.today) }
    subsample_kind { create(:subsample_kind) }
    refference_label { nil }
  end
end

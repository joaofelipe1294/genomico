FactoryBot.define do
  factory :subsample do
    storage_location { Faker::Lorem.sentence(word_count: 3) }
    sample { create(:sample) }
    collection_date { Faker::Date.between(from: 21.days.ago, to: Date.today) }
    subsample_kind { create(:subsample_kind) }
    refference_label { nil }
  end
end

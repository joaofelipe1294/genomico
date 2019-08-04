FactoryBot.define do
  factory :exam do
    offered_exam { create(:offered_exam) }
    exam_status_kind { create(:exam_status_kind) }
    start_date { Faker::Date.between(from: 21.days.ago, to: Date.today) }
    finish_date { Faker::Date.between(from: 21.days.ago, to: Date.today) }
    sample { nil }
    subsample { nil }
  end
end

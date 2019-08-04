FactoryBot.define do
  factory :exam_status_change do
    exam { create(:exam) }
    exam_status_kind { create(:exam_status_kind) }
    change_date { Faker::Date.between(from: 29.days.ago, to: Date.today) }
  end
end

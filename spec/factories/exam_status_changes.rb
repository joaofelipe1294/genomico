FactoryBot.define do
  factory :exam_status_change do
    exam { create(:exam) }
    exam_status_kind { create(:exam_status_kind) }
    change_date { Faker::Date.between(29.days.ago, Date.today) }
  end
end

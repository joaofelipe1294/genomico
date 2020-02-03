FactoryBot.define do
  factory :exam_status_change do
    exam { create(:exam) }
    new_status { :complete }
    change_date { Faker::Date.between(from: 29.days.ago, to: Date.today) }
  end
end

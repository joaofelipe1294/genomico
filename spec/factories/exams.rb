FactoryBot.define do
  factory :exam do
    offered_exam { create(:offered_exam) }
    status { :waiting_start }
    start_date { Faker::Date.between(from: 21.days.ago, to: Date.today) }
    finish_date { Faker::Date.between(from: 21.days.ago, to: Date.today) }
    internal_codes { [] }
    was_late { nil }
    lag_time { nil }
  end
end

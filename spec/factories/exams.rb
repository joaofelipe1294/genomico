FactoryBot.define do
  factory :exam do
    offered_exam { create(:offered_exam) }
    exam_status_kind { ExamStatusKind.WAITING_START }
    start_date { Faker::Date.between(from: 21.days.ago, to: Date.today) }
    finish_date { Faker::Date.between(from: 21.days.ago, to: Date.today) }
    internal_codes { [] }
  end
end

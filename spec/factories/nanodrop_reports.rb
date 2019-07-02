FactoryBot.define do
  factory :nanodrop_report do
    subsample { create(:subsample) }
    concentration { Faker::Number.decimal(3) }
    rate_260_280 { Faker::Number.decimal(3) }
    rate_260_230 { Faker::Number.decimal(3) }
  end
end

FactoryBot.define do
  factory :attendance do
    lis_code { Faker::Number.number(9).to_s }
    patient { create(:patient) }
  end
end

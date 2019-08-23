FactoryBot.define do
  factory :patient do
    name { Faker::Name.name }
    medical_record { Faker::Number.number(digits: 10).to_s }
    birth_date { Faker::Date.between(from: 19.years.ago, to: Date.today) }
    mother_name { Faker::Name.name }
    hospital {create(:hospital)}
    observations { Faker::Lorem.paragraph }
  end
end

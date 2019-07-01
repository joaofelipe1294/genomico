FactoryBot.define do
  factory :patient do
    name { Faker::Name.name }
    medical_record { Faker::Number.number(10).to_s }
    birth_date { Faker::Date.between(19.years.ago, Date.today) }
    mother_name { Faker::Name.name }
    hospital {create(:hospital)}
  end
end

FactoryBot.define do
  factory :offered_exam do
    name { Faker::Company.name }
  	field { create(:field) }
  	is_active { Faker::Boolean.boolean }
  end
end

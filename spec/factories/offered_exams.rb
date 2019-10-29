FactoryBot.define do
  factory :offered_exam do
    name { Faker::Company.name }
  	field { create(:field) }
  	is_active { true }
    refference_date { Faker::Number.number(digits: 2) }
    mnemonyc { "" }
  end
end

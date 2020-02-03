FactoryBot.define do
  factory :offered_exam do
    name { Faker::Company.name }
  	field { Field.all.sample }
  	is_active { true }
    refference_date { Faker::Number.number(digits: 2) }
    mnemonyc { "" }
    group { :ngs }
  end
end

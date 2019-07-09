FactoryBot.define do
  factory :sample_kind do
    name { Faker::Company.name }
    acronym { Faker::Company.name }
    refference_index {Faker::Number.number(3)}
  end
end

FactoryBot.define do
  factory :sample_kind do
    name { Faker::Company.name }
    acronym { Faker::Hacker.abbreviation }
    refference_index {Faker::Number.number(3)}
  end
end

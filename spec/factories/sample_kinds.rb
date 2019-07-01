FactoryBot.define do
  factory :sample_kind do
    name {Faker::Hacker.verb}
    acronym { Faker::Hacker.abbreviation }
    refference_index {Faker::Number.number(3)}
  end
end

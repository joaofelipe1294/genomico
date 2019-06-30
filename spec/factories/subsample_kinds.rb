FactoryBot.define do
  factory :subsample_kind do
    name { Faker::Book.genre }
    acronym { Faker::Hacker.abbreviation }
    refference_index {Faker::Number.number(3)}
  end
end

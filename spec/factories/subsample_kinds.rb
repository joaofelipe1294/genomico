FactoryBot.define do
  factory :subsample_kind do
    name { Faker::Book.genre }
    acronym { Faker::Company.name }
    refference_index {Faker::Number.number(3)}
  end
end

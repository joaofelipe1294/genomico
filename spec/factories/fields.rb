FactoryBot.define do
  factory :field do
    name { Faker::Book.genre }
  end
end

FactoryBot.define do
  factory :user_kind do
    name { Faker::Company.name }
  end
end

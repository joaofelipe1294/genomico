FactoryBot.define do
  factory :user do
    login { Faker::Internet.username }
    password { Faker::Internet.password(min_length: 8) }
    name { Faker::Name.name }
    is_active { true }
    kind { :user }
  end
end

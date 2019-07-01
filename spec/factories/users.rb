FactoryBot.define do
  factory :user do
    login { Faker::Internet.username }
    password { Faker::Internet.password(8) }
    name { Faker::Name.first_name }
    is_active { Faker::Boolean.boolean }
    user_kind { create(:user_kind) }
  end
end

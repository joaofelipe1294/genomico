FactoryBot.define do
  factory :suggestion do
    title { Faker::Name.name }
    description { "MyString" }
    requester { User.where(kind: :user).sample }
    current_status { nil }
    start_at { "2020-01-26 20:57:48" }
    finish_date { "2020-01-26 20:57:48" }
    kind { 1 }
  end
end

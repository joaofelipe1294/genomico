FactoryBot.define do
  factory :suggestion do
    title { "MyString" }
    description { "MyString" }
    requester { User.where(user_kind: UserKind.USER).sample }
    current_status { nil }
    start_at { "2020-01-26 20:57:48" }
    finish_date { "2020-01-26 20:57:48" }
    kind { 1 }
    time_forseen { 1.5 }
  end
end

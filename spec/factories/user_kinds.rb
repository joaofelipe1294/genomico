FactoryBot.define do
  factory :user_kind do
    name { Faker::TvShows::SiliconValley.company }
  end
end

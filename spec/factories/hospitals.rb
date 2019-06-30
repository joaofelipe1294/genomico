FactoryBot.define do
  factory :hospital do
    name { Faker::TvShows::SiliconValley.company }
  end
end

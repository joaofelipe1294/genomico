FactoryBot.define do
  factory :release_check do
    user { nil }
    release { nil }
    has_confirmed { false }
  end
end

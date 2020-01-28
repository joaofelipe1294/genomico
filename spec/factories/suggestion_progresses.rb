FactoryBot.define do
  factory :suggestion_progress do
    suggestion { Suggestion.all.sample }
    responsible { User.all.sample }
    old_status { nil }
    new_status { nil }
  end
end

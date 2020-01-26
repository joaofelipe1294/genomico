FactoryBot.define do
  factory :suggestion_progress do
    suggestion { Suggestion.all.sample }
    responsible { User.all.sample }
    old_status { 1 }
    new_status { 2 }
  end
end

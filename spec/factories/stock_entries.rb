FactoryBot.define do
  factory :stock_entry do
    reagent { nil }
    lot { "MyString" }
    shelf_life { "2019-11-22" }
    is_expired { false }
    amount { 1 }
    entry_date { "2019-11-22" }
    current_state { nil }
    location { "MyString" }
    user { nil }
    tag { "MyString" }
  end
end

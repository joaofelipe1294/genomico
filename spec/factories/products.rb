FactoryBot.define do
  factory :product do
    reagent { nil }
    lot { "MyString" }
    shelf_life { "MyString" }
    is_expired { false }
    amount { 1 }
    current_state { nil }
    location { "MyString" }
    tag { "MyString" }
    has_shelf_life { false }
    has_tag { false }
    open_at { "2019-12-03" }
    finished_at { "2019-12-03" }
    stock_entry { nil }
  end
end

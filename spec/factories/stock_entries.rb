FactoryBot.define do
  factory :stock_entry do
    reagent { Reagent.all.sample }
    lot { "87612387123" }
    has_shelf_life { true }
    shelf_life { 2.years.from_now }
    is_expired { false }
    amount { 250 }
    entry_date { Date.current }
    current_state { CurrentState.all.sample }
    location { "Triagem" }
    responsible { User.all.sample }
    tag { "8716237" }
  end
end

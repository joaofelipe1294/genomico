FactoryBot.define do
  factory :product do
    # reagent { Reagent.all.sample }
    lot { "987123kjabsd" }
    shelf_life { 3.years.from_now }
    is_expired { false }
    amount { 1 }
    current_state { CurrentState.STOCK }
    location { "Santuario" }
    tag { nil }
    has_shelf_life { true }
    has_tag { true }
    open_at { 3.months.ago }
    finished_at { nil }
    stock_entry { nil }
    brand { Brand.all.sample }
    stock_product { StockProduct.all.sample }
  end
end

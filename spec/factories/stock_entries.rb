FactoryBot.define do
  factory :stock_entry do
    entry_date { Date.current }
    responsible { User.all.sample }
    product { Product.all.sample }
  end
end

FactoryBot.define do
  factory :stock_entry do
    entry_date { Date.current }
    responsible { User.all.sample }
    product { Product.all.sample }
    stock_product { StockProduct.all.last }
  end
end

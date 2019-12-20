FactoryBot.define do
  factory :stock_out do
    stock_product { nil }
    product { nil }
    date { "2019-12-20" }
    responsible { nil }
  end
end

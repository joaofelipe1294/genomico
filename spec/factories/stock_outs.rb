FactoryBot.define do
  factory :stock_out do
    stock_product { nil }
    product { nil }
    date { Date.current }
    responsible { User.all.sample }
  end
end

FactoryBot.define do
  factory :internal_code do
    sample { create(:attendance).samples.first }
    field { create(:field) }
  end
end

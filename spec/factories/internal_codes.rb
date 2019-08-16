FactoryBot.define do
  factory :internal_code do
    sample { create(:sample) }
    field { create(:field) }
  end
end

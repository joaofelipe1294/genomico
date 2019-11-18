FactoryBot.define do
  factory :release do
    name { "Unidade 02" }
    tag { "v0.0.2" }
    message { "Add support to new pilots" }
    is_active { nil }
  end
end

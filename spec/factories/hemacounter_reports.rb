FactoryBot.define do
  factory :hemacounter_report do
    subsample { nil }
    valume { 1.5 }
    leukocyte_total_count { 1.5 }
    cellularity { 1.5 }
    pellet_leukocyte_count { 1.5 }
  end
end

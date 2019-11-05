FactoryBot.define do
  factory :hemacounter_report do
    subsample { Subsample.all.sample }
    volume { 1 }
    leukocyte_total_count { 1 }
    cellularity { 1 }
    pellet_leukocyte_count { 1.5 }
  end
end

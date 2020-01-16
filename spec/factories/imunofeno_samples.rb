FactoryBot.define do
  factory :imunofeno_sample, class: "Sample" do
    sample_kind { [SampleKind.LIQUOR, SampleKind.PERIPHERAL_BLOOD, SampleKind.BONE_MARROW].sample }
    has_subsample { false }
    entry_date { Date.current }
    collection_date { Date.current }
    refference_label { nil }
    receipt_notice { "1 frasco" }
    storage_location { "F -20" }
    attendance { nil }
  end
end

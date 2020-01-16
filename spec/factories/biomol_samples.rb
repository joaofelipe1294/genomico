FactoryBot.define do
  factory :biomol_sample, class: "Sample" do
    sample_kind { [SampleKind.SWAB, SampleKind.PERIPHERAL_BLOOD, SampleKind.BONE_MARROW, SampleKind.PARAFFIN_BLOCK].sample }
    has_subsample { false }
    entry_date { Date.current }
    collection_date { Date.current }
    refference_label { nil }
    receipt_notice { "1 frasco" }
    storage_location { "F -20" }
    attendance { nil }
  end
end

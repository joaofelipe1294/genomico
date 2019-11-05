module SubsampleSupport

  def fill_subsample_values subsample
    select(subsample.subsample_kind.name, from: "subsample[subsample_kind_id]").select_option if subsample.subsample_kind
    fill_in "subsample[storage_location]", with: subsample.storage_location if subsample.storage_location
    fill_in "subsample[observations]", with: subsample.observations if subsample.observations

    fill_in "subsample[nanodrop_report_attributes][concentration]", with: subsample.nanodrop_report.concentration.to_s if subsample.nanodrop_report.concentration
    fill_in "subsample[nanodrop_report_attributes][rate_260_280]", with: subsample.nanodrop_report.rate_260_280 if subsample.nanodrop_report.rate_260_280
    fill_in "subsample[nanodrop_report_attributes][rate_260_230]", with: subsample.nanodrop_report.rate_260_230 if subsample.nanodrop_report.rate_260_230

    fill_in "subsample[hemacounter_report_attributes][leukocyte_total_count]", with: subsample.hemacounter_report.leukocyte_total_count if subsample.hemacounter_report.leukocyte_total_count
    fill_in "subsample[hemacounter_report_attributes][volume]", with: subsample.hemacounter_report.volume if subsample.hemacounter_report.volume
    fill_in "subsample[hemacounter_report_attributes][pellet_leukocyte_count]", with: subsample.hemacounter_report.pellet_leukocyte_count if subsample.hemacounter_report.pellet_leukocyte_count

    fill_in "subsample[qubit_report_attributes][concentration]", with: subsample.qubit_report.concentration if subsample.qubit_report.concentration
  end

  def generate_subsample(sample: nil, subsample_kind: SubsampleKind.RNA)
    Subsample.new({
      subsample_kind: subsample_kind,
      sample: sample,
      storage_location: "some location",
      observations: "Turu bom",
      nanodrop_report: NanodropReport.new({
        concentration: Faker::Number.number(digits: 2),
        rate_260_280: Faker::Number.number(digits: 2),
        rate_260_230: Faker::Number.number(digits: 2),
      }),
      qubit_report: QubitReport.new({
        concentration: Faker::Number.number(digits: 2),
      }),
      hemacounter_report: HemacounterReport.new({
        leukocyte_total_count: Faker::Number.number(digits: 2),
        volume: Faker::Number.number(digits: 2),
        pellet_leukocyte_count: Faker::Number.number(digits: 2),
      })
    })
  end

end

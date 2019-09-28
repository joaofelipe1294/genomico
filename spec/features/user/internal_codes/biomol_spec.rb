require 'rails_helper'
require 'helpers/user'

RSpec.feature "User::InternalCodes::Biomols", type: :feature do

  before :each do
    Rails.application.load_seed
    patient = create(:patient)
    samples = [build(:sample, sample_kind: SampleKind.PERIPHERAL_BLOOD), build(:sample, sample_kind: SampleKind.SWAB)]
    exams = [
      build(:exam, offered_exam: OfferedExam.where(field: Field.BIOMOL).sample),
      build(:exam, offered_exam: OfferedExam.where(field: Field.BIOMOL).sample),
      build(:exam, offered_exam: OfferedExam.where(field: Field.BIOMOL).sample),
    ]
    attendance = create(:attendance, patient: patient, samples: samples, exams: exams)
    subsample = Subsample.create({
      collection_date: Date.today,
      sample: attendance.samples.sample,
      nanodrop_report: NanodropReport.new,
      qubit_report: QubitReport.new,
      subsample_kind: SubsampleKind.DNA
    })
  end

  it "list one internal code" do
    internal_code = InternalCode.create(field: Field.BIOMOL, subsample: Subsample.all.first)
    biomol_user_do_login
    click_link id: 'samples-dropdown'
    click_link id: 'samples-biomol'
    expect(find_all(class: 'biomol-sample').size).to eq 1
  end

  it "list 2 itens" do
    internal_code = InternalCode.create(field: Field.BIOMOL, subsample: Subsample.all.first)
    second_subsample = Subsample.create({
      collection_date: Date.today,
      sample: Attendance.all.first.samples.last,
      nanodrop_report: NanodropReport.new,
      qubit_report: QubitReport.new,
      subsample_kind: SubsampleKind.RNA
    })
    second_internal_code = InternalCode.create(field: Field.BIOMOL, subsample: second_subsample)
    biomol_user_do_login
    click_link id: 'samples-dropdown'
    click_link id: 'samples-biomol'
    expect(find_all(class: 'biomol-sample').size).to eq 2
  end

  it "list without biomol internal_codes" do
    internal_code = InternalCode.create(field: Field.FISH, subsample: Subsample.all.first)
    biomol_user_do_login
    click_link id: 'samples-dropdown'
    click_link id: 'samples-biomol'
    expect(find_all(class: 'biomol-sample').size).to eq 0
  end

end

require 'rails_helper'

def setup_attendance_with_no_exams
  patient = create(:patient)
  sample = Sample.new({
    sample_kind: SampleKind.PERIPHERAL_BLOOD,
     collection_date: Date.today
  })
  @attendance = Attendance.new({
    desease_stage: :drm,
    lis_code: Faker::Number.number,
    patient: patient,
    status: :progress,
    samples: [sample]
  })
end

RSpec.feature "User::Home::Charts", type: :feature do
  include UserLogin

  before :each do
    Rails.application.load_seed
    imunofeno_user_do_login
  end

  context "issues list validations" do

    it "without issues" do
      expect(find_all(class: 'issue').size).to eq 0
    end

    it "with one exam" do
      exam = Exam.new(offered_exam: create(:offered_exam, field: Field.IMUNOFENO))
      attendance = create(:attendance, exams: [exam])
      visit current_path
      expect(find_all(class: 'issue').size).to eq 1
    end

    it "with distinct field exam" do
      exam = Exam.new(offered_exam: create(:offered_exam, field: Field.BIOMOL))
      attendance = create(:attendance, exams: [exam])
      visit current_path
      expect(find_all(class: 'issue').size).to eq 0
    end

    it "with two exams" do
      exams = [
        Exam.new(offered_exam: create(:offered_exam, field: Field.IMUNOFENO)),
        Exam.new(offered_exam: create(:offered_exam, field: Field.IMUNOFENO))
      ]
      attendance = create(:attendance, exams: exams)
      visit current_path
      expect(find_all(class: 'issue').size).to eq 2
    end

    it "visit exam issue" do
      exam = Exam.new(offered_exam: create(:offered_exam, field: Field.IMUNOFENO))
      attendance = create(:attendance, exams: [exam])
      visit current_path
      expect(find_all(class: 'issue').size).to eq 1
      click_link class: 'attendance-code', match: :first
      expect(page).to have_current_path attendance_path(attendance, {tab: 'exams'})
    end

    it "filter issues" do
      exams = [
        Exam.new(offered_exam: create(:offered_exam, field: Field.IMUNOFENO)),
        Exam.new(offered_exam: create(:offered_exam, field: Field.IMUNOFENO))
      ]
      attendance = create(:attendance, exams: exams)
      visit current_path
      expect(find_all(class: 'issue').size).to eq 2
      offered_exam = Exam.all.first.offered_exam
      select(offered_exam.name, from: "offered_exam").select_option
      click_button id: 'btn-search'
      expect(find_all(class: 'issue').size).to eq 1
      select('Todos', from: "offered_exam").select_option
      click_button id: 'btn-search'
      expect(find_all(class: 'issue').size).to eq 2
    end

  end

  it "check if canceled exams are displayed on home" do
    Rails.application.load_seed
    attendance = setup_attendance_with_no_exams
    first_exam = Exam.new(status: :waiting_start, offered_exam: create(:offered_exam, field: Field.IMUNOFENO))
    second_exam = Exam.new(status: :progress, offered_exam: create(:offered_exam, field: Field.IMUNOFENO))
    third_exam = Exam.new(status: :canceled, offered_exam: create(:offered_exam, field: Field.IMUNOFENO))
    attendance.exams = [first_exam, second_exam, third_exam]
    attendance.save
    imunofeno_user_do_login
    expect(find_all(class: "issue").size).to eq 2
  end

end

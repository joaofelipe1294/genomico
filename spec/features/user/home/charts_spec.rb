require 'rails_helper'
require 'helpers/user'

def setup_attendance_with_no_exams
  patient = create(:patient)
  sample = Sample.new({
    sample_kind: SampleKind.PERIPHERAL_BLOOD,
     bottles_number: 1,
     collection_date: Date.today
  })
  @attendance = Attendance.new({
    desease_stage: DeseaseStage.DRM,
    lis_code: Faker::Number.number,
    patient: patient,
    attendance_status_kind: AttendanceStatusKind.IN_PROGRESS,
    samples: [sample]
  })
end

def reload_constants
  Object.send(:remove_const, :ExamStatusKinds) if Module.const_defined?(:ExamStatusKinds)
  Object.send(:remove_const, :AttendanceStatusKinds) if Module.const_defined?(:AttendanceStatusKinds)
  load 'app/models/concerns/exam_status_kinds.rb'
  load 'app/models/concerns/attendance_status_kinds.rb'
end

RSpec.feature "User::Home::Charts", type: :feature do

  before :each do
    Rails.application.load_seed
    reload_constants
    imunofeno_user_do_login
  end

  context "WAITING_EXAMS" do

    it "with zero exams" do
      expect(page).not_to have_selector '#waiting-exams-chart'
      expect(find(id: 'waiting-exams-number').text).to eq 0.to_s
    end

    it "with one exam" do
      exam = Exam.new(offered_exam: OfferedExam.where(field: Field.IMUNOFENO).where(is_active: true).sample, exam_status_kind: ExamStatusKind.WAITING_START)
      attendance = create(:attendance, exams: [exam])
      visit current_path
      expect(page).to have_selector '#waiting-exams-chart'
      expect(find(id: 'waiting-exams-number').text).to eq 1.to_s
    end

    context "two exams validations" do

      before :each do
        setup_attendance_with_no_exams
      end

      it "with two equal exams" do
        exams = [
          Exam.new(offered_exam: OfferedExam.where(field: Field.IMUNOFENO).sample),
          Exam.new(offered_exam: OfferedExam.where(field: Field.IMUNOFENO).sample)
        ]
        @attendance.exams = exams
        @attendance.save
        visit current_path
        expect(page).to have_selector '#waiting-exams-chart'
        expect(find(id: 'waiting-exams-number').text).to eq 2.to_s
      end

      it "with distinct areas exams" do
        exams = [
          Exam.new(offered_exam: OfferedExam.where(field: Field.IMUNOFENO).sample),
          Exam.new(offered_exam: OfferedExam.where(field: Field.BIOMOL).sample)
        ]
        @attendance.exams = exams
        @attendance.save
        visit current_path
        expect(page).to have_selector '#waiting-exams-chart'
        expect(find(id: 'waiting-exams-number').text).to eq 1.to_s
      end

    end

  end

  context "EXAMS_IN_PROGRESS" do

    it "without in progress exams" do
      expect(page).not_to have_selector '#in-progress-exams-chart'
      expect(find(id: 'in-progress-exams-number').text).to eq 0.to_s
    end

    it "with one exam" do
      exam = Exam.new({
        offered_exam: OfferedExam.where(field: Field.IMUNOFENO).sample,
        exam_status_kind: ExamStatusKind.IN_PROGRESS
      })
      attendance = create(:attendance, exams: [exam])
      visit current_path
      expect(page).to have_selector '#in-progress-exams-chart'
      expect(find(id: 'in-progress-exams-number').text).to eq 1.to_s
    end

    context "two exams validations" do

      before :each do
        setup_attendance_with_no_exams
      end

      it "with two equal exams" do
        exams = [
          Exam.new(offered_exam: OfferedExam.where(field: Field.IMUNOFENO).sample, exam_status_kind: ExamStatusKind.IN_PROGRESS),
          Exam.new(offered_exam: OfferedExam.where(field: Field.IMUNOFENO).sample, exam_status_kind: ExamStatusKind.IN_PROGRESS)
        ]
        @attendance.exams = exams
        @attendance.save
        visit current_path
        expect(page).to have_selector '#in-progress-exams-chart'
        expect(find(id: 'in-progress-exams-number').text).to eq 2.to_s
      end

      it "with distinct areas exams" do
        exams = [
          Exam.new(offered_exam: OfferedExam.where(field: Field.IMUNOFENO).sample, exam_status_kind: ExamStatusKind.IN_PROGRESS),
          Exam.new(offered_exam: OfferedExam.where(field: Field.BIOMOL).sample, exam_status_kind: ExamStatusKind.IN_PROGRESS)
        ]
        @attendance.exams = exams
        @attendance.save
        visit current_path
        expect(page).to have_selector '#in-progress-exams-chart'
        expect(find(id: 'in-progress-exams-number').text).to eq 1.to_s
      end

    end

  end

  context "late exams" do

    it "without delayed exams" do
      expect(page).not_to have_selector '#delayed-exams-chart'
      expect(find(id: 'delayed-exams-number').text).to eq 0.to_s
    end

    it "with one delayed exam" do
      exam = Exam.new({
        offered_exam: OfferedExam.where(field: Field.IMUNOFENO).sample,
        exam_status_kind: ExamStatusKind.IN_PROGRESS,
        created_at: 3.months.ago
      })
      attendance = create(:attendance, exams: [exam])
      visit current_path
      expect(page).to have_selector '#delayed-exams-chart'
      expect(find(id: 'delayed-exams-number').text).to eq 1.to_s
    end

    context "two exams validations" do

      before :each do
        setup_attendance_with_no_exams
      end

      it "with two equal exams" do
        exams = [
          Exam.new(offered_exam: OfferedExam.where(field: Field.IMUNOFENO).sample, exam_status_kind: ExamStatusKind.IN_PROGRESS, created_at: 3.months.ago),
          Exam.new(offered_exam: OfferedExam.where(field: Field.IMUNOFENO).sample, exam_status_kind: ExamStatusKind.IN_PROGRESS, created_at: 3.months.ago)
        ]
        @attendance.exams = exams
        @attendance.save
        visit current_path
        expect(page).to have_selector '#delayed-exams-chart'
        expect(find(id: 'delayed-exams-number').text).to eq 2.to_s
      end

      it "with distinct areas exams" do
        exams = [
          Exam.new(offered_exam: OfferedExam.where(field: Field.IMUNOFENO).sample, exam_status_kind: ExamStatusKind.IN_PROGRESS, created_at: 3.months.ago),
          Exam.new(offered_exam: OfferedExam.where(field: Field.BIOMOL).sample, exam_status_kind: ExamStatusKind.IN_PROGRESS, created_at: 3.months.ago)
        ]
        @attendance.exams = exams
        @attendance.save
        visit current_path
        expect(page).to have_selector '#delayed-exams-chart'
        expect(find(id: 'delayed-exams-number').text).to eq 1.to_s
      end

    end

  end

  context "issues list validations" do

    it "without issues" do
      expect(find_all(class: 'issue').size).to eq 0
    end

    it "with one exam" do
      exam = Exam.new(offered_exam: OfferedExam.where(field: Field.IMUNOFENO).sample)
      attendance = create(:attendance, exams: [exam])
      visit current_path
      expect(find_all(class: 'issue').size).to eq 1
    end

    it "with distinct field exam" do
      exam = Exam.new(offered_exam: OfferedExam.where(field: Field.BIOMOL).sample)
      attendance = create(:attendance, exams: [exam])
      visit current_path
      expect(find_all(class: 'issue').size).to eq 0
    end

    it "with two exams" do
      exams = [
        Exam.new(offered_exam: OfferedExam.where(field: Field.IMUNOFENO).sample),
        Exam.new(offered_exam: OfferedExam.where(field: Field.IMUNOFENO).sample)
      ]
      attendance = create(:attendance, exams: exams)
      visit current_path
      expect(find_all(class: 'issue').size).to eq 2
    end

    it "visit exam issue" do
      exam = Exam.new(offered_exam: OfferedExam.where(field: Field.IMUNOFENO).sample)
      attendance = create(:attendance, exams: [exam])
      visit current_path
      expect(find_all(class: 'issue').size).to eq 1
      click_link class: 'attendance-code', match: :first
      expect(page).to have_current_path workflow_path(attendance, {tab: 'exams'})
    end

    it "filter issues" do
      exams = [
        Exam.new(offered_exam: OfferedExam.where(field: Field.IMUNOFENO).order(id: :asc).first),
        Exam.new(offered_exam: OfferedExam.where(field: Field.IMUNOFENO).order(id: :asc).last)
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
    reload_constants
    attendance = setup_attendance_with_no_exams
    first_exam = Exam.new(exam_status_kind: ExamStatusKind.WAITING_START, offered_exam: OfferedExam.where(field: Field.IMUNOFENO).where(is_active: true).sample)
    second_exam = Exam.new(exam_status_kind: ExamStatusKind.IN_PROGRESS, offered_exam: OfferedExam.where(field: Field.IMUNOFENO).where(is_active: true).sample)
    third_exam = Exam.new(exam_status_kind: ExamStatusKind.CANCELED, offered_exam: OfferedExam.where(field: Field.IMUNOFENO).where(is_active: true).sample)
    attendance.exams = [first_exam, second_exam, third_exam]
    attendance.save
    imunofeno_user_do_login
    expect(find_all(class: "issue").size).to eq 2
  end

end

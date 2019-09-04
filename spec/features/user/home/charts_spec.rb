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

RSpec.feature "User::Home::Charts", type: :feature do

  before :each do
    imunofeno_user_do_login_with_seeds
  end

  context "WAITING_EXAMS" do

    it "with zero exams" do
      expect(page).not_to have_selector '#waiting-exams-chart'
      expect(find(id: 'waiting-exams-number').text).to eq 0.to_s
    end

    it "with one exam" do
      exam = Exam.new(offered_exam: OfferedExam.where(field: Field.IMUNOFENO).sample)
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




end

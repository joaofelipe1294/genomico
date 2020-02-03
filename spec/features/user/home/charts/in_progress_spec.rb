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

  context "EXAMS_IN_PROGRESS" do

    it "without in progress exams" do
      expect(page).not_to have_selector '#in-progress-exams-chart'
      expect(find(id: 'in-progress-exams-number').text).to eq 0.to_s
    end

    it "with one exam" do
      exam = Exam.new({
        offered_exam: create(:offered_exam, field: Field.IMUNOFENO),
        status: :progress
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
          Exam.new(offered_exam: create(:offered_exam, field: Field.IMUNOFENO), status: :progress),
          Exam.new(offered_exam: create(:offered_exam, field: Field.IMUNOFENO), status: :progress)
        ]
        @attendance.exams = exams
        @attendance.save
        visit current_path
        expect(page).to have_selector '#in-progress-exams-chart'
        expect(find(id: 'in-progress-exams-number').text).to eq 2.to_s
      end

      it "with distinct areas exams" do
        exams = [
          Exam.new(offered_exam: create(:offered_exam, field: Field.IMUNOFENO), status: :progress),
          Exam.new(offered_exam: create(:offered_exam, field: Field.BIOMOL), status: :progress)
        ]
        @attendance.exams = exams
        @attendance.save
        visit current_path
        expect(page).to have_selector '#in-progress-exams-chart'
        expect(find(id: 'in-progress-exams-number').text).to eq 1.to_s
      end

    end

  end

end

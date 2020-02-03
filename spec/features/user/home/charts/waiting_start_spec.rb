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

RSpec.feature "User::Home::Charts::Waiting_start", type: :feature do
  include UserLogin

  before :each do
    Rails.application.load_seed
    imunofeno_user_do_login
  end

  context "WAITING_EXAMS" do

    it "with zero exams" do
      expect(page).not_to have_selector '#waiting-exams-chart'
      expect(find(id: 'waiting-exams-number').text).to eq 0.to_s
    end

    it "with one exam" do
      exam = Exam.new(offered_exam: create(:offered_exam, field: Field.IMUNOFENO),status: :waiting_start)
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
          Exam.new(offered_exam: create(:offered_exam, field: Field.IMUNOFENO)),
          Exam.new(offered_exam: create(:offered_exam, field: Field.IMUNOFENO))
        ]
        @attendance.exams = exams
        @attendance.save
        visit current_path
        expect(page).to have_selector '#waiting-exams-chart'
        expect(find(id: 'waiting-exams-number').text).to eq 2.to_s
      end

      it "with distinct areas exams" do
        exams = [
          Exam.new(offered_exam: create(:offered_exam, field: Field.IMUNOFENO)),
          Exam.new(offered_exam: create(:offered_exam, field: Field.BIOMOL))
        ]
        @attendance.exams = exams
        @attendance.save
        visit current_path
        expect(page).to have_selector '#waiting-exams-chart'
        expect(find(id: 'waiting-exams-number').text).to eq 1.to_s
      end

    end

  end

end

require 'rails_helper'
require 'helpers/user'

RSpec.feature "User::Workflow::Exam::Reopens", type: :feature, js: true do

  context "reopen exam" do

    before :each do
      Rails.application.load_seed
    end

    it "reopen with complete attendance" do
      attendance = Attendance.create({
        lis_code: "981723987123",
        patient: create(:patient),
        attendance_status_kind: AttendanceStatusKind.COMPLETE,
        start_date: 1.month.ago,
        finish_date: 2.weeks.ago,
        desease_stage: DeseaseStage.all.sample,
        exams: [Exam.new(offered_exam: OfferedExam.where(field: Field.IMUNOFENO).sample)],
        samples: [Sample.new(sample_kind: SampleKind.PERIPHERAL_BLOOD, bottles_number: 1, collection_date: 3.days.ago)],
        })
      internal_code = InternalCode.create(sample: attendance.samples.first, field: Field.IMUNOFENO)
      exam = attendance.exams.first
      exam.internal_code = internal_code
      exam.exam_status_kind = ExamStatusKind.COMPLETE
      exam.finish_date = 3.days.ago
      exam.report = File.open "#{Rails.root}/spec/support_files/PDF.pdf"
      exam.save
      imunofeno_user_do_login
      visit workflow_path(attendance, {tab: "exams"})
      click_link class: "reopen-exam", match: :first
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_current_path workflow_path(attendance, {tab: "exams"})
      expect(find(id: 'success-warning').text).to eq I18n.t :exam_reopen_success
      updated_exam = Exam.find(exam.id)
      expect(updated_exam.exam_status_kind).to eq ExamStatusKind.IN_PROGRESS
      expect(Attendance.find(attendance.id).attendance_status_kind).to eq AttendanceStatusKind.IN_PROGRESS
    end

    it "with in progress attendance" do
      attendance = Attendance.create({
        lis_code: "981723987123",
        patient: create(:patient),
        attendance_status_kind: AttendanceStatusKind.IN_PROGRESS,
        start_date: 1.month.ago,
        desease_stage: DeseaseStage.all.sample,
        exams: [Exam.new(offered_exam: OfferedExam.where(field: Field.IMUNOFENO).sample), Exam.new(offered_exam: OfferedExam.where(field: Field.IMUNOFENO).sample)],
        samples: [Sample.new(sample_kind: SampleKind.PERIPHERAL_BLOOD, bottles_number: 1, collection_date: 3.days.ago)],
        })
      internal_code = InternalCode.create(sample: attendance.samples.first, field: Field.IMUNOFENO)
      exam = attendance.exams.first
      exam.internal_code = internal_code
      exam.exam_status_kind = ExamStatusKind.COMPLETE
      exam.finish_date = 3.days.ago
      exam.report = File.open "#{Rails.root}/spec/support_files/PDF.pdf"
      exam.save
      imunofeno_user_do_login
      visit workflow_path(attendance, {tab: "exams"})
      click_link class: "reopen-exam", match: :first
      page.driver.browser.switch_to.alert.accept
      expect(page).to have_current_path workflow_path(attendance, {tab: "exams"})
      expect(find(id: 'success-warning').text).to eq I18n.t :exam_reopen_success
      updated_exam = Exam.find(exam.id)
      expect(updated_exam.exam_status_kind).to eq ExamStatusKind.IN_PROGRESS
      expect(Attendance.find(attendance.id).attendance_status_kind).to eq AttendanceStatusKind.IN_PROGRESS
    end

  end

end

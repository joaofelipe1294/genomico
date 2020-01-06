require 'rails_helper'

RSpec.feature "User::Workflow::Exam::Reopens", type: :feature, js: true do
  include UserLogin

  context "reopen exam" do

    before :each do
      Rails.application.load_seed
    end

    def create_attendance status: AttendanceStatusKind.IN_PROGRESS
      attendance = Attendance.create({
        lis_code: "981723987123",
        patient: create(:patient),
        attendance_status_kind: status,
        start_date: 1.month.ago,
        finish_date: 2.weeks.ago,
        desease_stage: DeseaseStage.all.sample,
        exams: [Exam.new(offered_exam: OfferedExam.where(field: Field.IMUNOFENO).sample)],
        samples: [Sample.new(sample_kind: SampleKind.PERIPHERAL_BLOOD, collection_date: 3.days.ago)],
        })
        attendance
    end

    def create_complete_exam_with_report
      internal_code = InternalCode.create(sample: @attendance.samples.first, field: Field.IMUNOFENO)
      exam = @attendance.exams.first
      exam.internal_codes << internal_code
      exam.exam_status_kind = ExamStatusKind.COMPLETE
      exam.finish_date = 3.days.ago
      exam.report = File.open "#{Rails.root}/spec/support_files/PDF.pdf"
      exam.save
      exam
    end

    after :each do
      exam = create_complete_exam_with_report
      imunofeno_user_do_login
      visit workflow_path(@attendance, {tab: "exams"})
      page.driver.browser.accept_confirm
      click_link class: "reopen-exam", match: :first
      expect(page).to have_current_path workflow_path(@attendance, {tab: "exams"})
      expect(find(id: 'success-warning').text).to eq I18n.t :exam_reopen_success
      updated_exam = Exam.find(exam.id)
      expect(updated_exam.exam_status_kind).to eq ExamStatusKind.IN_PROGRESS
      expect(Attendance.find(@attendance.id).attendance_status_kind).to eq AttendanceStatusKind.IN_PROGRESS
    end

    it "reopen with complete attendance" do
      @attendance = create_attendance status: AttendanceStatusKind.COMPLETE
    end

    it "with in progress attendance" do
      @attendance = create_attendance status: AttendanceStatusKind.IN_PROGRESS
    end

  end

end

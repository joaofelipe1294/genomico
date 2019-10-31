require 'rails_helper'

RSpec.feature "User::Indicators::ConcludedExams", type: :feature do
  include UserLogin

  def navigate_to
    click_link id: "indicators-dropdown"
    click_link id: "concluded-exams"
  end

  context "count display validation" do

    before :each do
      Rails.application.load_seed
      imunofeno_user_do_login
    end

    it "with zero exams" do
      navigate_to
      expect(find(id: "complete-exams-count").text).to eq 0.to_s
    end

    it "with one exam", js: true do
      exam = Exam.create({offered_exam: OfferedExam.all.sample, exam_status_kind: ExamStatusKind.COMPLETE})
      navigate_to
      expect(find(id: "complete-exams-count").text).to eq 1.to_s
    end

    it "with three complete exams" do
      Exam.create({offered_exam: OfferedExam.all.sample, exam_status_kind: ExamStatusKind.COMPLETE})
      Exam.create({offered_exam: OfferedExam.all.sample, exam_status_kind: ExamStatusKind.COMPLETE})
      Exam.create({offered_exam: OfferedExam.all.sample, exam_status_kind: ExamStatusKind.COMPLETE})
      navigate_to
      expect(find(id: "complete-exams-count").text).to eq 3.to_s
    end

    it "with 2 complete exams, 1 in progress, 1 waiting_start, 1 complete_without_report, 1 in repeat" do
      Exam.create({offered_exam: OfferedExam.all.sample, exam_status_kind: ExamStatusKind.COMPLETE})
      Exam.create({offered_exam: OfferedExam.all.sample, exam_status_kind: ExamStatusKind.COMPLETE})
      Exam.create({offered_exam: OfferedExam.all.sample, exam_status_kind: ExamStatusKind.COMPLETE})
      Exam.create({offered_exam: OfferedExam.all.sample, exam_status_kind: ExamStatusKind.COMPLETE_WITHOUT_REPORT})
      Exam.create({offered_exam: OfferedExam.all.sample, exam_status_kind: ExamStatusKind.WAITING_START})
      Exam.create({offered_exam: OfferedExam.all.sample, exam_status_kind: ExamStatusKind.IN_REPEAT})
      navigate_to
      expect(find(id: "complete-exams-count").text).to eq 3.to_s
    end

  end

  context "search by date" do

    before :all do
      Rails.application.load_seed
    end

    before :each do
      imunofeno_user_do_login
      Exam.create({offered_exam: OfferedExam.all.sample, exam_status_kind: ExamStatusKind.COMPLETE, finish_date: 15.days.ago})
      Exam.create({offered_exam: OfferedExam.all.sample, exam_status_kind: ExamStatusKind.COMPLETE, finish_date: 12.days.ago})
      Exam.create({offered_exam: OfferedExam.all.sample, exam_status_kind: ExamStatusKind.COMPLETE, finish_date: 10.days.ago})
      Exam.create({offered_exam: OfferedExam.all.sample, exam_status_kind: ExamStatusKind.COMPLETE, finish_date: 8.days.ago})
      Exam.create({offered_exam: OfferedExam.all.sample, exam_status_kind: ExamStatusKind.COMPLETE, finish_date: 5.days.ago})
      Exam.create({offered_exam: OfferedExam.all.sample, exam_status_kind: ExamStatusKind.COMPLETE, finish_date: 2.days.ago})
      navigate_to
    end

    it "15 days ago until yesterday" do
      fill_in id: "start_date", with: 15.days.ago
      fill_in id: "end_date", with: 1.day.ago
      click_button id: "btn-search"
      expect(find(id: "complete-exams-count").text).to eq 6.to_s
    end

    it "15 days ago until 5 days ago" do
      fill_in id: "start_date", with: 15.days.ago
      fill_in id: "end_date", with: 5.day.ago
      click_button id: "btn-search"
      expect(find(id: "complete-exams-count").text).to eq 5.to_s
    end

    it "15 days ago until 10 days ago" do
      fill_in id: "start_date", with: 15.days.ago
      fill_in id: "end_date", with: 10.day.ago
      click_button id: "btn-search"
      expect(find(id: "complete-exams-count").text).to eq 3.to_s
    end


    it "3 days ago untill 1 day ago" do
      fill_in id: "start_date", with: 3.days.ago
      fill_in id: "end_date", with: 1.day.ago
      click_button id: "btn-search"
      expect(find(id: "complete-exams-count").text).to eq 1.to_s
    end

  end

end

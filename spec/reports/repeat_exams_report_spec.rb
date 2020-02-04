require 'rails_helper'
require 'exam_report'

describe 'RepeatExamsReport#exams' do
  include ActiveSupport::Testing::TimeHelpers

  before :each do
    Rails.application.load_seed
    create(:patient)
    first_offered_exam = create(:offered_exam)
    second_offered_exam = create(:offered_exam)
    exams = [build(:exam, offered_exam: first_offered_exam), build(:exam, offered_exam: second_offered_exam)]
    attendance = create(:attendance, exams: exams)
    exam = attendance.reload.exams.first
    exam.status = :in_repeat
    exam.change_status create(:user).id
  end

  describe "when not filtering by date" do
    before(:each) { @repeat_exams_report = RepeatExamsReport.new({}) }

    context "when were exams in repeat" do
      it "is expected to return the relation" do
        relation = @repeat_exams_report.relation
        expect(relation.keys.size).to match 1
      end
      it "is expected to return total count" do
        expect(@repeat_exams_report.count).to match 1
      end
    end
  end

  describe "When applying a date filter" do
    context "when will be results" do
      it "is expected to return it in relation" do
        @report = @repeat_exams_report = RepeatExamsReport.new({start_date: 1.day.ago, finish_date: 2.days.from_now})
        expect(@report.relation.keys.size).to match 1
      end
    end
    context "when there is no results " do
      it "it is expected to return a empty hash" do
        @repeat_exams_report = RepeatExamsReport.new({start_date: 10.day.ago, finish_date: 2.days.ago})
        expect(@repeat_exams_report.relation.keys.size).to match 0
      end
    end
  end

end

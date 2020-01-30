require 'rails_helper'
require 'exam_report'

describe 'StandProductionReport#exams' do

  before :each do
    Rails.application.load_seed
    create(:patient)
    create(:patient)
    first_attendance = create(:biomol_attendance)
    first_attendance.exams << create(:exam)
    first_attendance.exams << create(:exam)
    first_attendance.exams.first.update created_at: 20.days.ago
    second_attendance = create(:biomol_attendance)
    third_attendance = create(:imunofeno_attendance)
  end

  describe "#attendances_count" do
    context "when searching without a date" do
      it "is expected to return all attendances of olny one field" do
        report = StandProductionReport.new stand: :biomol
        count = report.attendance_count
        expect(count).to match 2
      end
    end
    context "when searchin by date" do
      it "is expected to return all attendances created between  start_date and finish_date" do
        report = StandProductionReport.new stand: :biomol, start_date: 1.day.ago, finish_date: 1.day.from_now
        count = report.attendance_count
        expect(count).to match 1
      end
    end
  end

end

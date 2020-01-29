require 'rails_helper'

describe 'StandProductionReport#exams' do

  before :each do
    Rails.application.load_seed
    create(:patient)
    create(:patient)
    first_attendance = create(:biomol_attendance)
    first_attendance.exams.first.update created_at: 20.days.ago
    second_attendance = create(:biomol_attendance)
    third_attendance = create(:imunofeno_attendance)
  end

  describe "#exams_count" do
    context "when searching without a date" do
      it "is expected to return all exams of olny one field" do
        report = StandProductionReport.new field: Field.BIOMOL
        count = report.exams_count
        expect(count).to match 2
      end
    end
    context "when searchin by date" do
      it "is expected to return all exams created between  start_date and finish_date" do
        report = StandProductionReport.new field: Field.BIOMOL, start_date: 1.day.ago, finish_date: 1.day.from_now
        count = report.exams_count
        expect(count).to match 1
      end
    end
  end

  describe "#exams_relation" do
    context "when searching without a date" do
      it "is expected to return a hash with all exams of a field" do
        report = StandProductionReport.new field: Field.IMUNOFENO
        relations = report.exams_relation
        expect(relations.keys.size).to match 1
        expect(relations[relations.keys.first]).to match 1
      end
    end
    context "when searching with a date" do
      it "is expected to return a hash with exams created between start_date and finish_date" do
        report = StandProductionReport.new field: Field.BIOMOL, start_date: 1.day.ago, finish_date: 1.day.from_now
        relations = report.exams_relation
        expect(relations.keys.size).to match 1
        expect(relations[relations.keys.first]).to match 1
      end
    end
  end

end

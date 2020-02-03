require 'rails_helper'
require 'exam_report'

describe 'GlobalProductionReport#exams' do
  include ActiveSupport::Testing::TimeHelpers

  before :each do
    Rails.application.load_seed
    @biomol_exam = create(:offered_exam, field: Field.BIOMOL)
    @imunofeno_exam = create(:offered_exam, field: Field.IMUNOFENO)
    @fish_exam = create(:offered_exam, field: Field.FISH)
    create(:patient)
  end

  describe "exams relation" do

    context "when are exams of all fiels" do

      before :each do
        create(:attendance, exams: [build(:exam, offered_exam: @biomol_exam), build(:exam, offered_exam: @biomol_exam)])
        create(:attendance, exams: [build(:exam, offered_exam: @imunofeno_exam)])
        create(:attendance, exams: [build(:exam, offered_exam: @fish_exam), build(:exam, offered_exam: @fish_exam), build(:exam, offered_exam: @fish_exam)])
        @report = GlobalProductionReport.new
      end

      it "is expected to return biomol exams created" do
        expect(@report.field_relation["Biologia Molecular"]).to match 2
      end

      it "is expected to return fish exams in cyto group" do
        expect(@report.field_relation["Citogenética"]).to match 3
      end

      it "is expected to return imunofeno exams" do
        expect(@report.field_relation["Imunofenotipagem"]).to match 1
      end
    end
    context "where are exams of only some fields" do
      before :each do
        create(:attendance, exams: [build(:exam, offered_exam: @imunofeno_exam)])
        create(:attendance, exams: [build(:exam, offered_exam: @fish_exam), build(:exam, offered_exam: @fish_exam), build(:exam, offered_exam: @fish_exam)])
        @report = GlobalProductionReport.new
      end
      it "is expected to return only fields with exams" do
        expect(@report.field_relation.keys.size).to match 2
      end
    end
  end

  describe "When applying a date filter" do
    context "when will be results" do
      it "is expected to return it in relation" do
        travel_to 1.day.ago do
          create(:attendance, exams: [build(:exam, offered_exam: @biomol_exam), build(:exam, offered_exam: @imunofeno_exam)])
        end
        travel_to 8.days.ago do
          create(:attendance, exams: [build(:exam, offered_exam: @biomol_exam), build(:exam, offered_exam: @imunofeno_exam)])
        end
        @report = GlobalProductionReport.new(params: {start_date: 3.day.ago, end_date: Date.current})
        expect(@report.field_relation.keys.size).to match 2
      end
    end
    context "when there is no results " do
      it "it is expected to return a empty hash" do
        travel_to Time.zone.local(2000, 1, 6, 12, 0) do
          create(:attendance, exams: [build(:exam, offered_exam: @biomol_exam), build(:exam, offered_exam: @imunofeno_exam)])
        end
        @report = GlobalProductionReport.new(params: {start_date: 1.day.ago, end_date: Date.current})
        expect(@report.field_relation.keys.size).to match 0
      end
    end
  end

end

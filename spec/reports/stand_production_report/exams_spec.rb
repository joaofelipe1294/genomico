require 'rails_helper'

describe 'StandProductionReport#exams' do

  describe "#exams_count" do
    context "when searching without a date" do
      it "is expected to return all exams of olny one field"
    end
    context "when searchin by date" do
      it "is expected to return all exams created between  start_date and finish_date"
    end
  end

end

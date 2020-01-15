require 'rails_helper'

describe 'status_service' do

  before :each do
    @service = StatusService.new
  end

  context "when user check app status" do

    context "when there is no backups" do

      it "is expected to display custom message" do
        response = @service.call
        expect(response[:backup]).to match I18n.t(:without_backups_message)
      end

    end

    context "when there are backups" do

      it "is expected to display last backup creation" do
        Backup.create(generated_at: Time.now)
        response = @service.call
        expect(response[:backup]).not_to match I18n.t(:without_backups_message)
      end

    end

    context "when there are all data" do

      it "is expected to display" do
        Rails.application.load_seed
        patient = create(:patient)
        create(:patient)
        create(:attendance, patient: patient)
        Backup.create(generated_at: Time.now)
        response = @service.call
        expect(response[:patients]).to eq 2
        expect(response[:attendances]).to eq 1
        expect(response[:exams]).to eq 2
        expect(response[:backup]).not_to match I18n.t(:without_backups_message)
      end

    end

  end

end

require 'rails_helper'

def visit_workflow
  create_attendance
  imunofeno_user_do_login
  click_link class: 'attendance-code', match: :first
  click_button id: 'attendance_nav'
end

RSpec.feature "User::Workflow::AttendanceInfos", type: :feature, js: true do
  include DataGenerator
  include UserLogin

  before :each do
    Rails.application.load_seed
  end

  context "success updates" do

    before :each do
      visit_workflow
    end

    after :each do
      click_button id: 'btn-save'
      expect(find(id: 'success-warning').text).to eq I18n.t :attendance_update_success
    end

    it "chage desease_stage" do
      select(DeseaseStage.RETURN.name, from: 'attendance[desease_stage_id]').select_option
    end

    it "correct change cid" do
      fill_in "attendance[cid_code]", with: Faker::Number.number(digits: 8).to_s
    end

    it "remove cid_code" do
      fill_in "attendance[cid_code]", with: ""
    end

    it "change lis_code" do
      fill_in "attendance[lis_code]", with: Faker::Number.number(digits: 8).to_s
    end

    it "change health_ensurance" do
      select(HealthEnsurance.all.sample.name, from: "attendance[health_ensurance_id]").select_option
    end

    it "doctor name" do
      fill_in "attendance[doctor_name]", with: Faker::Name.name
    end

    it "without doctor name" do
      fill_in "attendance[doctor_name]", with: ""
    end

    it "doctor_crm" do
      fill_in "attendance[doctor_crm]", with: Faker::Number.number(digits: 5).to_s
    end

    it "without doctor_crm" do
      fill_in "attendance[doctor_crm]", with: ""
    end

    it "observations" do
      fill_in "attendance[observations]", with: Faker::Lorem.sentence
    end

    it "without observations" do
      fill_in "attendance[observations]", with: ""
    end

  end

  context "update with errors" do

    before :each do
      visit_workflow
    end

    it "without lis_code" do
      fill_in "attendance[lis_code]", with: ""
      click_button id: 'btn-save'
      expect(find(class: 'error', match: :first).text).to eq "Código LisNet não pode ficar em branco"
    end

    it "duplicated lis_code" do
      duplicated = create(:attendance)
      fill_in "attendance[lis_code]", with: duplicated.lis_code
      click_button id: 'btn-save'
      expect(find(class: 'error').text).to eq "Código LisNet já está em uso"
    end

  end

end

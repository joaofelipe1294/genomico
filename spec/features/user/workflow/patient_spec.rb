require 'rails_helper'

RSpec.feature "User::Workflow::Patients", type: :feature, js: true do
  include UserLogin
  include DataGenerator

  it "edit patient observations" do
    Rails.application.load_seed
    create_attendance
    imunofeno_user_do_login
    click_link class: 'attendance-code', match: :first
    click_button id: 'patient_nav'
    fill_in "patient[observations]", with: "Algum valor aleatório ..."
    click_button id: 'btn-save'
    expect(find(id: 'success-warning').text).to eq I18n.t :edit_patient_success
  end

end

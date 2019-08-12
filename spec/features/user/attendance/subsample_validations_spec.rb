require 'rails_helper'
require 'helpers/attendance'
require 'helpers/user'

def extract_subsample
  click_button id: 'sample_nav'
  click_link class: 'new-subsample', match: :first
  select(SubsampleKind.all.sample.name, from: 'subsample[subsample_kind_id]').select_option
  fill_in 'subsample[storage_location]', with: 'F -80'
  fill_in 'subsample[nanodrop_report_attributes][rate_260_280]', with: Faker::Number.decimal(l_digits: 2)
  fill_in 'subsample[nanodrop_report_attributes][rate_260_230]', with: Faker::Number.decimal(l_digits: 2)
  fill_in 'subsample[nanodrop_report_attributes][concentration]', with: Faker::Number.decimal(l_digits: 2)
  fill_in 'subsample[qubit_report_attributes][concentration]', with: Faker::Number.decimal(l_digits: 2)
  click_button id: 'btn-save-subsample'
  click_button id: 'subsample_nav'
end


RSpec.feature "User::Attendance::SubsampleValidations", type: :feature do

  before :each do
    create_attendance
    do_login
    navigate_to_workflow
    extract_subsample
  end

  # it "navigate to subsamples tab", js: true do
  #   expect(find(id: 'success-warning').text).to eq "Subamostra cadastrada com sucesso."
  # end

  it "edit subsample", js: true do
    click_button id: 'subsample_nav'
    sleep 8
  end



end

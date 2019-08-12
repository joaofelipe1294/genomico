require 'rails_helper'
require 'helpers/user'
require 'helpers/attendance'

RSpec.feature "User::Attendance::SampleValidations", type: :feature do

  before :each do
    create_attendance
    do_login
    navigate_to_workflow
    click_button id: 'sample_nav'
  end

  context "create sample" do

    it "navigate to new sample", js: true do
      click_link id: 'btn-new-sample'
      expect(find(id: 'form-name').text).to eq "Nova amostra"
    end

    it "try to create new sample without botles number", js: true do
      expect(@attendance.samples.size).to eq 1
      click_link id: 'btn-new-sample'
      click_button class: 'btn-outline-primary'
      expect(page).to have_no_selector('#success-warning')
      expect(page).to have_no_selector('#danger-warning')
      expect(@attendance.samples.size).to eq 1
    end

    it "create new sample to attendance", js: true do
      expect(@attendance.samples.size).to eq 1
      click_link id: 'btn-new-sample'
      select(SampleKind.all.sample.name, from: 'sample[sample_kind_id]').select_option
      fill_in 'sample[collection_date]', with: Date.today
      fill_in 'sample[bottles_number]', with: "2"
      fill_in 'sample[storage_location]', with: "F2"
      click_button id: 'btn-save-sample'
      expect(find(id: 'success-warning').text).to eq "Amostra cadastrada com sucesso."
      expect(Attendance.find(@attendance.id).samples.size).to eq 2
    end

    it "navigate to extract subsample", js: true do
      click_link class: 'new-subsample', match: :first
      expect(find(id: 'form-name').text).to eq "Nova subamostra"
    end

  end

  context "extract new subsample" do

    before :each do
      expect(@attendance.samples.last.subsamples.size).to eq 0
      click_link class: 'new-subsample', match: :first
      select(SubsampleKind.all.sample.name, from: 'subsample[subsample_kind_id]').select_option
      fill_in 'subsample[storage_location]', with: 'F -80'
    end

    after :each do
      click_button 'btn-save-subsample'
      expect(find(id: 'success-warning').text).to eq "Subamostra cadastrada com sucesso."
      expect(Attendance.find(@attendance.id).samples.last.subsamples.size).to eq 1
    end

    it "new subsample only nanodrop", js: true do
      fill_in 'subsample[nanodrop_report_attributes][rate_260_280]', with: Faker::Number.decimal(l_digits: 2)
      fill_in 'subsample[nanodrop_report_attributes][rate_260_230]', with: Faker::Number.decimal(l_digits: 2)
      fill_in 'subsample[nanodrop_report_attributes][concentration]', with: Faker::Number.decimal(l_digits: 2)
    end

    it "new subsample only qubit", js: true do
      fill_in 'subsample[qubit_report_attributes][concentration]', with: Faker::Number.decimal(l_digits: 2)
    end

    it "new subsample with nanodrop and qubit", js: true do
      fill_in 'subsample[nanodrop_report_attributes][rate_260_280]', with: Faker::Number.decimal(l_digits: 2)
      fill_in 'subsample[nanodrop_report_attributes][rate_260_230]', with: Faker::Number.decimal(l_digits: 2)
      fill_in 'subsample[nanodrop_report_attributes][concentration]', with: Faker::Number.decimal(l_digits: 2)
      fill_in 'subsample[qubit_report_attributes][concentration]', with: Faker::Number.decimal(l_digits: 2)
    end

  end

  context "edit sample" do

    it "navigate to edit sample", js: true do
      click_link id: 'btn-edit-sample'
      expect(find(id: 'form-name').text).to eq "Editar amostra"
    end

    it "without bottles number", js: true do
      click_link id: 'btn-edit-sample'
      fill_in 'sample[collection_date]', with: Date.today
      fill_in 'sample[bottles_number]', with: ""
      fill_in 'sample[storage_location]', with: "F -80"
      click_button id: 'btn-save-sample'
      expect(page).to have_no_selector('#success-warning')
      expect(page).to have_no_selector('#danger-warning')
    end

    it "correct sample edit", js: true do
      click_link id: 'btn-edit-sample'
      fill_in 'sample[collection_date]', with: Date.today
      fill_in 'sample[bottles_number]', with: "1"
      fill_in 'sample[storage_location]', with: "F -80"
      click_button id: 'btn-save-sample'
      expect(find(id: 'success-warning').text).to eq "Amostra editada com sucesso."
    end

  end

  it "remove sample without exam", js: true do
    expect(@attendance.samples.size).to eq 1
    click_link id: 'btn-remove-sample'
    page.driver.browser.switch_to.alert.accept
    expect(find(id: 'success-warning').text).to eq "Amostra removida com sucesso."
    expect(Attendance.find(@attendance.id).samples.size).to eq 0
  end

  it "remove sample with exam", js: true do
    expect(@attendance.samples.size).to eq 1
    click_button id: 'exam_nav'
    click_link id: 'start-exam'
    click_button id: 'btn-start-exam'
    click_button id: 'sample_nav'
    expect(page).not_to have_selector("#btn-remove-sample")
  end

end

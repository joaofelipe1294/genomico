require 'rails_helper'

RSpec.feature "User::Workflow::Samples", type: :feature, js: true do
  include UserLogin
  include DataGenerator

  context "sample" do

    before :each do
      Rails.application.load_seed
      create_attendance
      imunofeno_user_do_login
      click_link class: 'attendance-code', match: :first
      click_button id: 'sample_nav'
    end

    it "verify if samples are listed" do
      expect(find_all(class: 'sample').size).to eq @attendance.samples.size
    end

    it "extract internal_code from sample" do
      click_link class: 'new-internal-code', match: :first
      expect(find(id: 'success-warning').text).to eq I18n.t :new_internal_code_success
      click_button id: "sample_nav"
      expect(find_all(class: 'internal-code').size).to eq 1
    end

    it "edit sample" do
      click_link class: 'edit-sample', match: :first
      sample = Sample.new({
        sample_kind: SampleKind.SWAB,
        collection_date: Date.today,
        receipt_notice: "Houve atraso na entrega",
        storage_location: 'F -80'
      })
      select(sample.sample_kind.name, from: "sample[sample_kind_id]").select_option
      fill_in "sample[collection_date]", with: Date.current.to_s
      fill_in "sample[receipt_notice]", with: "Mais três frascos recebidos"
      fill_in "sample[storage_location]", with: "F -10"
      click_button id: "btn-save"
      expect(find(id: 'success-warning').text).to eq I18n.t :edit_sample_success
    end

    it "remove sample" do
      page.driver.browser.accept_confirm
      click_link class: 'remove-sample', match: :first
      expect(find(id: 'success-warning').text).to eq I18n.t :remove_sample_success
    end

    it "remove internal_code" do
      click_link class: 'new-internal-code', match: :first
      visit current_path
      click_button id: 'sample_nav'
      page.driver.browser.accept_confirm
      click_link class: 'remove-internal-code'
      expect(find(id: 'success-warning').text).to eq I18n.t :remove_internal_code_success
      expect(find_all(class: 'internal-code').size).to eq 0
    end

    it "new sample" do
      click_link id: 'new-sample'
      sample = Sample.new({
        sample_kind: SampleKind.all.sample,
        collection_date: 2.days.from_now,
        receipt_notice: "2 frascos",
        storage_location: "F 18"
      })
      select(sample.sample_kind.name, from: "sample[sample_kind_id]").select_option
      fill_in "sample[collection_date]", with: sample.collection_date
      fill_in "sample[receipt_notice]", with: sample.receipt_notice
      fill_in "sample[storage_location]", with: sample.storage_location
      click_button id: 'btn-save'
      expect(find(id: 'success-warning').text).to eq I18n.t :new_sample_success
      click_button id: "sample_nav"
      expect(find_all(class: 'sample').size).to eq Sample.all.size
    end

  end

end

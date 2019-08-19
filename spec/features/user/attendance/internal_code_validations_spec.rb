require 'rails_helper'
require 'helpers/attendance'
require 'helpers/user'

RSpec.feature "User::Attendance::InternalCodesValidations", type: :feature do

  context "Internal codes", js: true do

    before :each do
      user_do_login
      create_attendance
      navigate_to_workflow
      click_button id: 'sample_nav'
      click_link id: 'btn-internal-code'
      click_button id: 'btn-save'
    end

    it "Correct single internal code" do
      expect(find_all(class: 'internal-code-line').size).to eq 1
      expect(find(id: 'success-warning').text).to eq "Código interno salvo com sucesso."
    end

    it "Correct three internal codes, same field" do
      expect(find_all(class: 'internal-code-line').size).to eq 1
      click_button id: 'btn-save'
      expect(find_all(class: 'internal-code-line').size).to eq 2
      click_button id: 'btn-save'
      expect(find_all(class: 'internal-code-line').size).to eq 3
      expect(find(id: 'success-warning').text).to eq "Código interno salvo com sucesso."
    end

    it "Correct internal code removal" do
      visit current_path
      click_link class: 'btn-remove-internal-code', match: :first
      page.driver.browser.switch_to.alert.accept
      expect(find(id: 'success-warning').text).to eq "Código interno removido com sucesso."
      expect(InternalCode.all.size).to eq 0
    end

  end

end

require 'rails_helper'

RSpec.feature "Admin::Release::Accesses", type: :feature do
  include UserLogin

  context "access" do

    before(:each) { Rails.application.load_seed }

    it "access without login" do
      visit new_release_path
      expect(page).to have_current_path root_path
    end

    it "correct access" do
      admin_do_login
      click_link id: "release-dropdown"
      click_link id: "new-release"
      expect(page).to have_current_path new_release_path
    end

    it "login as user" do
      imunofeno_user_do_login
      visit new_release_path
      expect(page).to have_current_path root_path
    end

  end

end

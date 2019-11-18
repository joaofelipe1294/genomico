require 'rails_helper'

RSpec.feature "Admin::Release::News", type: :feature do
  include UserLogin

  it "navigate to" do
    Rails.application.load_seed
    release = build(:release)
    admin_do_login
    click_link id: "release-dropdown"
    click_link id: "new-release"
    fill_in "release[name]", with: release.name
    fill_in "release[tag]", with: release.tag
    fill_in "release[message]", with: release.message
    click_button id: "btn-save"
    expect(page).to have_current_path releases_path
    expect(find(id: "success-warning").text).to eq I18n.t :new_release_success
  end

  context "without values" do

    def check_error field
      click_button id: "btn-save"
      expect(find_all(class: "error").size).to eq 1
      expect(find(class: "error", match: :first).text).to eq "#{field} não pode ficar em branco"
    end

    before :each do
      Rails.application.load_seed
      release = build(:release)
      admin_do_login
      click_link id: "release-dropdown"
      click_link id: "new-release"
      fill_in "release[name]", with: release.name
      fill_in "release[tag]", with: release.tag
      fill_in "release[message]", with: release.message
    end

    it "name" do
      fill_in "release[name]", with: ""
      check_error "Nome"
    end

    it "tag" do
      fill_in "release[tag]", with: ""
      check_error "Tag"
    end

    it "message" do
      fill_in "release[message]", with: ""
      check_error "Mensagem"
    end

  end

  context "duplicated values" do

    before :each do
      Rails.application.load_seed
      @release = create(:release)
      admin_do_login
      click_link id: "release-dropdown"
      click_link id: "new-release"
      fill_in "release[name]", with: "Some name"
      fill_in "release[tag]", with: "v12.2.13"
      fill_in "release[message]", with: "Some notation"
    end

    it "name" do
      fill_in "release[name]", with: @release.name
      click_button id: "btn-save"
      expect(find_all(class: "error").size).to eq 1
      expect(find(class: "error").text).to eq "Nome já está em uso"
    end

    it "tag" do
      fill_in "release[tag]", with: @release.tag
      click_button id: "btn-save"
      expect(find_all(class: "error").size).to eq 1
      expect(find(class: "error").text).to eq "Tag já está em uso"
    end

  end

end

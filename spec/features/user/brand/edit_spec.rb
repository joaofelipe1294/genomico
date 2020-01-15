require 'rails_helper'

RSpec.feature "User::Brand::Edits", type: :feature do
  include UserLogin

  context "edit" do

    before :each do
      Rails.application.load_seed
      imunofeno_user_do_login
      Brand.create([
        {name: 'Rails'},
        {name: 'Django'},
        {name: 'VRaptor'},
        {name: 'Play'},
        {name: 'Grails'},
      ])
      click_link id: "stock"
      click_link id: 'brands-dropdown'
      click_link id: 'brands'
      click_link class: 'edit-brand', match: :first
    end

    it "correct edit" do
      fill_in "brand[name]", with: 'Magento'
      click_button id: 'btn-save'
      expect(page).to have_current_path home_user_index_path
      expect(find(id: 'success-warning').text).to eq I18n.t :edit_brand_success
    end

    it "without name edit" do
      fill_in "brand[name]", with: ""
      click_button id: 'btn-save'
      expect(page).to have_current_path brand_path Brand.all.order(name: :asc).first
      expect(find(class: "error").text).to eq "Nome não pode ficar em branco"
    end

    it "duplicated name" do
      fill_in "brand[name]", with: "Grails"
      click_button id: 'btn-save'
      expect(page).to have_current_path brand_path Brand.all.order(name: :asc).first
      expect(find(class: "error").text).to eq "Nome já está em uso"
    end

  end

end

require 'rails_helper'
require 'helpers/user'

RSpec.feature "User::Brand::Indices", type: :feature do

  context "brands" do

    before :each do
      Rails.application.load_seed
      imunofeno_user_do_login
    end

    it "navigate to brand list" do
      click_link id: 'stock-dropdown'
      click_link id: 'brands'
      expect(page).to have_current_path brands_path
    end

    it "count brands" do
      Brand.create([
        { name: 'Apple' },
        { name: 'Amazon' },
        { name: 'Microsoft' },
        { name: 'Oracle' },
        { name: '37 Signals' },
      ])
      click_link id: 'stock-dropdown'
      click_link id: 'brands'
      expect(find_all(class: 'brand').size).to eq Brand.all.size
    end

    it "visit update brand" do
      Brand.create([
        {name: 'Apple'},
        {name: 'Facebook'}
      ])
      click_link id: 'stock-dropdown'
      click_link id: 'brands'
      click_link class: 'edit-brand', match: :first
      expect(page).to have_current_path edit_brand_path(Brand.all.order(name: :asc).first)
    end

  end

end

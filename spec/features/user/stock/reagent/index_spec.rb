require 'rails_helper'
require 'helpers/user'

RSpec.feature "User::Stock::Reagent::Indices", type: :feature do

  it "access without login" do
    visit reagents_path
    expect(page).to have_current_path root_path
    expect(find(id: 'danger-warning').text).to eq I18n.t :wrong_credentials_message
  end

  context "count listed elements" do

    before :all do
      Rails.application.load_seed
    end

    before :each do
      imunofeno_user_do_login
      click_link id: 'stock-dropdown'
      click_link id: 'reagents'
    end

    it "count list elements - 0" do
      expect(find_all(class: 'reagent').size).to eq Reagent.all.size
    end

    it "count list elements - 1" do
      create(:reagent)
      visit current_path
      expect(find_all(class: 'reagent').size).to eq Reagent.all.size
    end

    it "count list elements - 3" do
      create(:reagent)
      create(:reagent)
      create(:reagent)
      visit current_path
      expect(find_all(class: 'reagent').size).to eq Reagent.all.size
    end

  end

  context "search by name" do

    before :all do
      Reagent.delete_all
      Rails.application.load_seed
      create(:reagent, name: 'CD3')
      create(:reagent, name: 'CD8')
      create(:reagent, name: 'YOLO')
      create(:reagent, name: 'CD45')
      create(:reagent, name: 'Tubo')
    end

    before :each do
      imunofeno_user_do_login
      click_link id: 'stock-dropdown'
      click_link id: 'reagents'
      expect(find_all(class: 'reagent').size).to eq 5
    end

    it "search by name" do
      fill_in "name", with: 'cd'
      click_button id: 'btn-search-by-name'
      expect(page).to have_current_path(reagents_path, ignore_query: true)
      expect(find_all(class: 'reagent').size).to eq 3
    end

    it "search by invalid name" do
      fill_in "name", with: "INVALIDO"
      click_button id: 'btn-search-by-name'
      expect(find_all(class: 'reagent').size).to eq 0
    end

    it "search with empty number" do
      fill_in "name", with: ''
      click_button id: 'btn-search-by-name'
      expect(find_all(class: 'reagent').size).to eq 5
    end

  end


end

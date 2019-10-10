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
      expect(find_all(class: 'reagent').size).to eq 0
    end

    it "count list elements - 1" do
      create(:reagent)
      visit current_path
      expect(find_all(class: 'reagent').size).to eq 1
    end

    it "count list elements - 3" do
      create(:reagent)
      create(:reagent)
      create(:reagent)
      visit current_path
      expect(find_all(class: 'reagent').size).to eq 3
    end

  end

end

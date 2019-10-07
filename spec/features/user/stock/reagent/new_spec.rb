require 'rails_helper'
require 'helpers/user'

def fill_in_values
  fill_in "reagent[product_description]", with: @reagent.product_description if @reagent.product_description
  fill_in "reagent[name]", with: @reagent.name if @reagent.name
  fill_in "reagent[mv_code]", with: @reagent.mv_code if @reagent.mv_code
  fill_in "reagent[product_code]", with: @reagent.product_code if @reagent.product_code
  fill_in "reagent[usage_per_test]", with: @reagent.usage_per_test if @reagent.usage_per_test
  select(Brand.all.first.name, from: "reagent[brand]").select_option if @reagent.brand
  fill_in "reagent[first_warn_at]", with: @reagent.first_warn_at if @reagent.first_warn_at
  fill_in "reagent[danger_warn_at]", with: @reagent.danger_warn_at if @reagent.danger_warn_at
end

RSpec.feature "User::Stock::Reagent::News", type: :feature do

  context "Reagent::New" do

    it "visit new reagent" do
      Rails.application.load_seed
      imunofeno_user_do_login
      click_link id: 'stock-dropdown'
      click_link id: 'new-reagent'
      expect(page).to have_current_path new_reagent_path
    end

    it "visit without login" do
      visit new_reagent_path
      expect(page).to have_current_path root_path
      expect(find(id: 'danger-warning').text).to eq I18n.t :wrong_credentials_message
    end

    context "correct cases" do

      before :all do
        Rails.application.load_seed
        create(:brand, name: 'Umbrella')
      end

      before :each do
        imunofeno_user_do_login
        click_link id: 'stock-dropdown'
        click_link id: 'new-reagent'
        @reagent = build(:reagent)
        fill_in_values
      end

      after :each do
        click_button id: "btn-save"
        expect(page).to have_current_path home_user_index_path
        expect(find(id: 'success-warning').text).to eq I18n.t :new_reagent_success
      end

      it "complete reagent" do
      end

      it "without field" do
        find(id: 'belong_to_many_fields').click
      end

      it "without usage_per_test" do
        fill_in "reagent[usage_per_test]", with: ""
      end

      it "without first_warn_at" do
        fill_in "reagent[first_warn_at]", with: ""
      end

      it "without danger_warn_at" do
        fill_in "reagent[danger_warn_at]", with: ""
      end

    end

    context "without values" do

      before :all do
        Rails.application.load_seed
        create(:brand, name: 'Apple')
      end

      before :each do
        imunofeno_user_do_login
        click_link id: 'stock-dropdown'
        click_link id: 'new-reagent'
        @reagent = build(:reagent)
        fill_in_values
      end

      after :each do
        expect(page).to have_current_path reagents_path
      end

      it "name" do
        fill_in "reagent[name]", with: ''
        click_button id: 'btn-save'
        expect(find(class: "error", match: :first).text).to eq "Nome não pode ficar em branco"
      end

      it "product_description" do
        fill_in "reagent[product_description]", with: ""
        click_button id: 'btn-save'
        expect(find(class: 'error', match: :first).text).to eq "Descrição do produto não pode ficar em branco"
      end

      it "mv_code" do
        fill_in "reagent[mv_code]", with: ""
        click_button id: 'btn-save'
        expect(find(class: "error", match: :first).text).to eq "Código MV não pode ficar em branco"
      end

      it "product_code" do
        fill_in "reagent[product_code]", with: ""
        click_button id: "btn-save"
        expect(find(class: "error", match: :first).text).to eq "Código do produto não pode ficar em branco"
      end

    end

    context "duplicated values" do

      before :all do
        Rails.application.load_seed
        create(:brand, name: "Nerv")
        create(:reagent, name: "Some name", product_description: "Other name")
      end

      before :each do
        imunofeno_user_do_login
        click_link id: 'stock-dropdown'
        click_link id: 'new-reagent'
        @reagent = build(:reagent)
        fill_in_values
      end

      it "name" do
        fill_in "reagent[name]", with: "Some name"
        click_button id: "btn-save"
        expect(page).to have_current_path reagents_path
        expect(find(class: "error", match: :first).text).to eq "Nome já está em uso"
      end

      it "product_description" do
        fill_in "reagent[product_description]", with: "Other name"
        click_button id: "btn-save"
        expect(page).to have_current_path reagents_path
        expect(find(class: "error", match: :first).text).to eq "Descrição do produto já está em uso"
      end

    end

  end


end

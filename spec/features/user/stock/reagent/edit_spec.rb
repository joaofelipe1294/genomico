require 'rails_helper'
require 'helpers/user'

def expect_correct_edition
  click_button id: 'btn-save'
  expect(page).to have_current_path reagents_path
  expect(find(id: 'success-warning').text).to eq I18n.t :edit_reagent_success
end

def generate_new_reagent
  @other_reagent = create(:reagent)
  visit current_path
end

RSpec.feature "User::Stock::Reagent::Edits", type: :feature do

  context "navigations" do

    before :all do
      Rails.application.load_seed
      create(:reagent)
    end

    it "navigate without login" do
      visit edit_reagent_path(Reagent.all.first)
      expect(page).to have_current_path root_path
      expect(find(id: 'danger-warning').text).to eq I18n.t :wrong_credentials_message
    end

    it "navigate with login" do
      imunofeno_user_do_login
      click_link id: 'stock-dropdown'
      click_link id: 'reagents'
      click_link class: 'edit-reagent', match: :first
      expect(page).to have_current_path edit_reagent_path(Reagent.all.first)
    end

  end

  context "change atributes" do

    before :all do
      Rails.application.load_seed
    end

    before :each do
      imunofeno_user_do_login
      @original_reagent = create(:reagent)
      visit edit_reagent_path(@original_reagent)
      @new_reagent = build(:reagent, brand: Brand.all.sample)
    end

    it "complete" do
      fill_in "reagent[product_description]", with: @new_reagent.product_description
      fill_in "reagent[name]", with: @new_reagent.name
      find(id: 'belong_to_single_field').click
      fill_in "reagent[mv_code]", with: @new_reagent.mv_code
      fill_in "reagent[product_code]", with: @new_reagent.product_code
      select(@new_reagent.brand.name, from: "reagent[brand_id]").select_option
      fill_in "reagent[first_warn_at]", with: @new_reagent.first_warn_at
      fill_in "reagent[danger_warn_at]", with: @new_reagent.danger_warn_at
      expect_correct_edition
    end

    context "PRODUCT_DESCRIPTION" do

      it "valid" do
        fill_in "reagent[product_description]", with: @new_reagent.product_description
        expect_correct_edition
      end

      it "without" do
        fill_in "reagent[product_description]", with: ""
        click_button id: 'btn-save'
        expect(find(class: 'error', match: :first).text).to eq "#{Reagent.human_attribute_name :product_description} não pode ficar em branco"
      end

      it "duplicated" do
        generate_new_reagent
        fill_in "reagent[product_description]", with: @other_reagent.product_description
        click_button id: 'btn-save'
        expect(find(class: 'error', match: :first).text).to eq "#{Reagent.human_attribute_name :product_description} já está em uso"
      end

    end

    context "NAME" do

      it "valid" do
        fill_in "reagent[name]", with: @new_reagent.name
        expect_correct_edition
      end

      it "without" do
        fill_in "reagent[name]", with: ""
        click_button id: 'btn-save'
        expect(find(class: 'error', match: :first).text).to eq "#{Reagent.human_attribute_name :name} não pode ficar em branco"
      end

      it "without" do
        generate_new_reagent
        fill_in "reagent[name]", with: @other_reagent.name
        click_button id: 'btn-save'
        expect(find(class: 'error', match: :first).text).to eq "#{Reagent.human_attribute_name :name} já está em uso"
      end

    end

    context "FIELD" do

      it "change to no field" do
        find(id: 'belong_to_many_fields').click
        expect_correct_edition
        visit edit_reagent_path(@original_reagent.id)
        expect(find(id: "belong_to_many_fields")).to be_checked
      end

      it "change to field" do
        @original_reagent.update(field: nil)
        visit edit_reagent_path(@original_reagent.id)
        find(id: 'belong_to_single_field').click
        expect_correct_edition
        visit edit_reagent_path(@original_reagent.id)
        expect(find(id: "belong_to_single_field")).to be_checked
      end

    end

    context "MV_CODE" do

      it "correct" do
        fill_in "reagent[mv_code]", with: @new_reagent.mv_code
        expect_correct_edition
      end

      it "without" do
        fill_in "reagent[mv_code]", with: ""
        click_button id: 'btn-save'
        expect(find(class: "error", match: :first).text).to eq "#{Reagent.human_attribute_name :mv_code} não pode ficar em branco"
      end

      it "duplicated" do
        generate_new_reagent
        fill_in "reagent[mv_code]", with: @other_reagent.mv_code
        click_button id: 'btn-save'
        expect(find(class: "error", match: :first).text).to eq "#{Reagent.human_attribute_name :mv_code} já está em uso"
      end

    end

    context "product_code" do

      it "correct" do
        fill_in "reagent[product_code]", with: @new_reagent.product_code
        expect_correct_edition
      end

      it "without" do
        fill_in "reagent[product_code]", with: ""
        click_button id: 'btn-save'
        expect(find(class: "error", match: :first).text).to eq "#{Reagent.human_attribute_name :product_code} não pode ficar em branco"
      end

      it "duplicated" do
        generate_new_reagent
        fill_in "reagent[product_code]", with: @other_reagent.product_code
        click_button id: "btn-save"
        expect(find(class: "error", match: :first).text).to eq "#{Reagent.human_attribute_name :product_code} já está em uso"
      end

    end

  end

end

require 'rails_helper'

RSpec.feature "User::StockEntry::News", type: :feature, js: true do
  include UserLogin

  before :each do
    Rails.application.load_seed
    create(:reagent, field: Field.BIOMOL)
    biomol_user_do_login
    visit new_stock_entry_path
    fill_in_values
  end

  def success_check
    click_button id: "btn-save"
    expect(page).to have_current_path display_new_tag_path(StockEntry.all.last)
    expect(find(id: "success-warning").text).to eq I18n.t :new_stock_entry_success
  end

  def fill_in_values
    select(Field.BIOMOL.name, from: "fields-select").select_option
    fill_in "stock_entry[lot]", with: "871623AC"
    fill_in "stock_entry[shelf_life]", with: 3.years.from_now
    fill_in "stock_entry[amount]", with: 2
    fill_in "stock_entry[location]", with: "Triagem"
  end

  it "complete" do
    success_check
  end

  it "without lot" do
    fill_in "stock_entry[lot]", with: ""
    click_button id: "btn-save"
    expect(find(class: "error", match: :first).text).to eq "Lote não pode ficar em branco"
  end

  it "without shelf_date" do
    choose 'stock_entry[has_shelf_life]', option: "false"
    success_check
  end

  it "with shelf_date" do
    choose 'stock_entry[has_shelf_life]', option: "true"
    fill_in "stock_entry[shelf_life]", with: 3.years.from_now
    success_check
    expect(StockEntry.all.order(:id).last.is_expired).to eq false
  end

  it "with shelf_date, but expired" do
    choose "stock_entry[has_shelf_life]", option: "true"
    fill_in "stock_entry[shelf_life]", with: 1.month.ago
    success_check
    expect(StockEntry.all.order(:id).last.is_expired).to eq true
  end

  it "without amount" do
    fill_in "stock_entry[amount]", with: ""
    click_button id: "btn-save"
    expect(find(class: "error", match: :first).text).to eq "Quantidade não pode ficar em branco"
  end

  it "with zero amount" do
    fill_in "stock_entry[amount]", with: "0"
    click_button id: "btn-save"
    expect(find(class: "error", match: :first).text).to eq "Quantidade deve ser maior que zero"
  end

  it "with negative amount" do
    fill_in "stock_entry[amount]", with: "-1"
    click_button id: "btn-save"
    expect(find(class: "error", match: :first).text).to eq "Quantidade deve ser maior que zero"
  end

  it "without location" do
    fill_in "stock_entry[location]", with: ""
    click_button id: "btn-save"
    expect(find(class: "error", match: :first).text).to eq "Localização não pode ficar em branco"
  end

  it "with tag" do
    choose "stock_entry[has_tag]", option: "true"
    success_check
    expect(StockEntry.all.last.tag).to eq "#{Field.BIOMOL.name[0, 3]}#{1}"
  end

  it "without tag" do
    choose "stock_entry[has_tag]", option: "false"
    click_button id: "btn-save"
    expect(page).to have_current_path stock_entries_path
  end

end

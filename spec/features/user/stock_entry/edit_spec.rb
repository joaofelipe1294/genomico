require 'rails_helper'

RSpec.feature "User::StockEntry::Edits", type: :feature do
  include UserLogin

  before :each do
    Rails.application.load_seed
    reagent = create(:reagent, field: Field.IMUNOFENO)
    create(:user)
    stock_entry = create(:stock_entry, reagent: reagent)
    create(:reagent, field: Field.IMUNOFENO)
    create(:reagent, field: Field.BIOMOL)
    biomol_user_do_login
    visit edit_stock_entry_path(stock_entry)
  end

  def success_check
    click_button id: "btn-save"
    expect(page).to have_current_path stock_entries_path
    expect(find(id: "success-warning").text).to eq I18n.t :edit_stock_entry_success
  end

  def error_check param_name
    click_button "btn-save"
    expect(find(class: "error", match: :first).text).to eq "#{param_name} não pode ficar em branco"
  end

  it "correct edit", js: true do
    select(Field.BIOMOL.name, from: "fields-select").select_option
    success_check
  end

  it "without lot" do
    fill_in "stock_entry[lot]", with: ""
    # click_button "btn-save"
    # expect(find(class: "error", match: :first).text).to eq "Lote não pode ficar em branco"
    error_check "Lote"
  end

  it "change lot" do
    fill_in "stock_entry[lot]", with: "871623kjasb"
    success_check
  end

  it "with shelf_life" do
    choose "stock_entry[has_shelf_life]", option: "true"
    fill_in "stock_entry[shelf_life]", with: 3.months.from_now
    success_check
  end

  it "without shelf_life" do
    choose "stock_entry[has_shelf_life]", option: "false"
    success_check
  end

  it "without amount" do
    fill_in "stock_entry[amount]", with: ""
    error_check "Quantidade"
  end

  it "change current_state" do
    select(CurrentState.IN_USE.name, from: "stock_entry[current_state_id]").select_option
    success_check
  end

end

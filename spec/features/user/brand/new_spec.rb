require 'rails_helper'
require 'helpers/user'

RSpec.feature "User::Brand::News", type: :feature do

  before :each do
    Rails.application.load_seed
    imunofeno_user_do_login
    click_link id: 'stock-dropdown'
    click_link id: 'new-brand'
  end

  it "new brand" do
    fill_in "brand[name]", with: "Umbrella corp."
    click_button id: 'btn-save'
    expect(page).to have_current_path home_user_index_path
    expect(find(id: "success-warning").text).to eq I18n.t :new_brand_success
  end

  it "without name" do
    click_button id: 'btn-save'
    expect(page).to have_current_path brands_path
    expect(find(class: "error", match: :first).text).to eq "Nome não pode ficar em branco"
  end

  it "duplicated name" do
    brand = Brand.create(name: "Umbrella corp.")
    fill_in "brand[name]", with: brand.name
    click_button id: 'btn-save'
    expect(page).to have_current_path brands_path
    expect(find(class: 'error', match: :first).text).to eq "Nome já está em uso"
  end

end

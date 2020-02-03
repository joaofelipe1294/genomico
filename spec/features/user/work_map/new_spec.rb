require 'rails_helper'

def work_map_setup
  Rails.application.load_seed
  create(:patient)
  create(:imunofeno_attendance)
  imunofeno_user_do_login
  @internal_code = InternalCode.create({
    sample: Sample.all.first,
    field: Field.IMUNOFENO
  })
  @internal_code = InternalCode.find @internal_code.id
  click_link id: 'work-map-dropdown'
  click_link id: 'new-work-map'
end

RSpec.feature "User::WorkMap::News", type: :feature do
  include UserLogin
  include DataGenerator

  context "navigation" do

    before :each do
      Rails.application.load_seed
    end

    it "with login" do
      imunofeno_user_do_login
      click_link id: 'work-map-dropdown'
      click_link id: 'new-work-map'
      expect(page).to have_current_path new_work_map_path
    end

    it "without login" do
      visit new_work_map_path
      expect(page).to have_current_path root_path
      expect(find(id: 'danger-warning').text).to eq I18n.t :wrong_credentials_message
    end

  end

  context "work_map validations", js: true do

    before :each do
      work_map_setup
    end

    it "add internal_code" do
      fill_in "internal-code", with: @internal_code.code
      click_button id: 'btn-search'
      expect(find_all(class: 'internal-code').size).to eq InternalCode.all.size
      expect(find_all(class: 'remove').size).to eq 1
    end

    it "remove internal_code" do
      fill_in "internal-code", with: @internal_code.code
      click_button id: 'btn-search'
      click_button class: 'remove', match: :first
      expect(find_all('internal-code').size).to eq 0
    end

  end

  it "correct work_map", js: true do
    work_map_setup
    fill_in "internal-code", with: @internal_code.code
    click_button id: 'btn-search'
    fill_in "work_map[name]", with: 'Some random name'
    attach_file "work_map[map]", "#{Rails.root}/spec/support_files/PDF_2.pdf"
    click_button id: 'btn-save'
    expect(page).to have_current_path home_user_index_path
    expect(find(id: 'success-warning').text).to eq I18n.t :create_work_map_success
  end

  it "without internal-code", js: true do
    work_map_setup
    fill_in "work_map[name]", with: 'Some random name'
    attach_file "work_map[map]", "#{Rails.root}/spec/support_files/PDF_2.pdf"
    click_button id: 'btn-save'
    expect(find(id: 'danger-warning').text).to eq "Amostras não pode ficar em branco"
    expect(page).to have_current_path new_work_map_path
  end

  it "without name", js: true do
    work_map_setup
    fill_in "internal-code", with: @internal_code.code
    click_button id: 'btn-search'
    attach_file "work_map[map]", "#{Rails.root}/spec/support_files/PDF_2.pdf"
    click_button id: 'btn-save'
    expect(find(id: 'danger-warning').text).to eq "Identificador não pode ficar em branco"
    expect(page).to have_current_path new_work_map_path
  end

  it "without pdf map", js: true do
    work_map_setup
    fill_in "internal-code", with: @internal_code.code
    click_button id: 'btn-search'
    fill_in "work_map[name]", with: 'Some random name'
    click_button id: 'btn-save'
    expect(page).to have_current_path new_work_map_path
    expect(find(id: 'danger-warning').text).to eq "PDF com o mapa de trabalho não pode ficar em branco"
  end

  it "with many samples", js: true do
    work_map_setup
    internal_code = InternalCode.create({
      sample: Sample.all.last,
      field: Field.IMUNOFENO
    })
    internal_code = InternalCode.find internal_code.id
    fill_in "internal-code", with: @internal_code.code
    click_button id: 'btn-search'
    fill_in "internal-code", with: internal_code.code
    click_button id: 'btn-search'
    fill_in "work_map[name]", with: 'Some random name'
    attach_file "work_map[map]", "#{Rails.root}/spec/support_files/PDF_2.pdf"
    click_button id: 'btn-save'
    expect(page).to have_current_path home_user_index_path
    expect(find(id: 'success-warning').text).to eq I18n.t :create_work_map_success
  end

  it "with invalid internal code", js: true do
    work_map_setup
    page.driver.browser.accept_confirm
    fill_in "internal-code", with: '1231223123'
    click_button id: 'btn-search'
    expect(find_all(class: 'internal-code').size).to eq 0
  end

end

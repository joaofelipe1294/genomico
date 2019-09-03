require 'rails_helper'
require 'helpers/user'

RSpec.feature "User::Home::Searches", type: :feature do

  before :each do
    user_do_login_with_seeds
    create(:patient, name: 'Alien')
    create(:patient, name: 'Smooth ali')
    create(:patient,name: 'Smooth')
  end

  after :each do
    expect(page).to have_current_path(patients_path, ignore_query: true)
  end

  it "search patient name" do
    fill_in 'patient-name-search', with: 'moo'
    click_button id: 'btn-search-patient'
    expect(find_all(class: 'patient').size).to eq 2
  end

  it "blank search" do
    click_button id: 'btn-search-patient'
    expect(find_all(class: 'patient').size).to eq Patient.all.size
  end

  it "search with no result" do
    fill_in 'patient-name-search', with: 'langley'
    click_button id: 'btn-search-patient'
    expect(find_all(class: 'patient').size).to eq 0
  end

end

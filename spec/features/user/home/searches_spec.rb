require 'rails_helper'
require 'helpers/user'

RSpec.feature "User::Home::Searches", type: :feature do

  it "search patient name" do
    user_do_login_with_seeds
    create(:patient, name: 'Alien')
    create(:patient, name: 'Smooth ali')
    create(:patient,name: 'Smooth')
    fill_in 'patient-name-search', with: 'moo'
    click_button id: 'btn-search-patient'
    expect(page).to have_current_path(patients_path, ignore_query: true)
    expect(find_all(class: 'patient').size).to eq 2
  end

end

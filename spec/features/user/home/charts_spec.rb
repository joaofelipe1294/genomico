require 'rails_helper'
require 'helpers/user'

RSpec.feature "User::Home::Charts", type: :feature do

  it "with zero exams" do
    imunofeno_user_do_login_with_seeds
    expect(page).not_to have_selector '#waiting-exams-chart'
    expect(find(id: 'waiting-exams-number').text).to eq 0.to_s
  end

  it "with one exam" do
    # create(:attendance, ) # TODO: continuar daki 4
  end

end

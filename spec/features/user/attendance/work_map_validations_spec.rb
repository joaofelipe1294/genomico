require 'rails_helper'
require 'helpers/user'
require 'helpers/attendance'

RSpec.feature "User::Attendance::WorkMapValidations", type: :feature do

  before :each do
    Rails.application.load_seed
    do_login
    click_link id: 'work-map-dropdown'
    click_link id: 'new-work-map'
  end

  it "navigate to new work_map", js: true do
    expect(page).to have_current_path("/work_maps/new")
  end

  it "create new work_map", js: true do
    create_attendance
    fill_in "work_map[name]", with: "Algum valor"
    attach_file("work_map[map]", Rails.root + "spec/support_files/PDF.pdf")
    select(SampleKind.last.name, from: 'sample_kind').select_option
    click_button id: 'btn_add_sample'
    click_button id: 'btn_save'
    expect(@attendance.work_maps.size).to eq 1
    expect(find(id: 'form-name').text).to eq "Mapa de trabalho"
  end

  # TODO: continuar testes de workmap

end

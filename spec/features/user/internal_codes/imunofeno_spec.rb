require 'rails_helper'
require 'helpers/user'
require 'helpers/attendance'

def create_imunofeno_internal_codes
  attendance = create_attendance
  InternalCode.create({
    field: Field.IMUNOFENO,
    sample: Sample.all.first,
    exams: [Exam.all.sample]
  })
  InternalCode.create({
    field: Field.IMUNOFENO,
    sample: Sample.all.last,
    exams: [Exam.all.sample]
  })
end

RSpec.feature "User::InternalCodes::Imunofenos", type: :feature do

  it "navigate to imunofeno internal_codes without login" do
    visit imunofeno_internal_codes_path
    expect(page).to have_current_path root_path
    expect(find(id: 'danger-warning').text).to eq I18n.t :wrong_credentials_message
  end

  context "navigate to imunofeno imternal-codes" do

    before :each do
      Rails.application.load_seed
      imunofeno_user_do_login
      click_link id: 'samples-dropdown'
      click_link id: 'samples-imunofeno'
    end

    it "correct navigation" do
      expect(page).to have_current_path imunofeno_internal_codes_path
    end

    it "with one internal code" do
      attendance = create_attendance
      InternalCode.create({
        field: Field.IMUNOFENO,
        sample: Sample.all.sample,
        exams: [Exam.all.sample]
      })
      visit current_path
      expect(find_all(class: 'internal-code').size).to eq InternalCode.where(field: Field.IMUNOFENO).size
    end

    it "without internal codes" do
      expect(find_all(class: 'internal-code').size).to eq InternalCode.where(field: Field.IMUNOFENO).size
    end

    it "with one IMUNFENO and one BIOMOL" do
      attendance = create_attendance
      InternalCode.create({
        field: Field.IMUNOFENO,
        sample: Sample.all.sample,
        exams: [Exam.all.sample]
      })
      InternalCode.create({
        field: Field.BIOMOL,
        sample: Sample.all.sample,
        exams: [Exam.all.sample]
      })
      visit current_path
      expect(find_all(class: 'internal-code').size).to eq InternalCode.where(field: Field.IMUNOFENO).size
    end

  end

  context "searches" do

    before :each do
      Rails.application.load_seed
      create_imunofeno_internal_codes
      imunofeno_user_do_login
      click_link id: 'samples-dropdown'
      click_link id: 'samples-imunofeno'
    end

    it "empty search" do
      visit current_path
      click_button id: 'btn-search'
      expect(find_all(class: 'internal-code').size).to eq InternalCode.where(field: Field.IMUNOFENO).size
    end

    it "search correct code" do
      visit current_path
      internal_code = InternalCode.where(field: Field.IMUNOFENO).sample
      fill_in "code", with: internal_code.code
      click_button id: 'btn-search'
      expect(find_all(class: 'internal-code').size).to eq 1
    end

    it "search invalid code" do
      fill_in "code", with: "871623876"
      click_button id: 'btn-search'
      expect(find_all(class: 'internal-code').size).to eq 0
    end

  end

end

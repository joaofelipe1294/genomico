require 'rails_helper'
require 'helpers/user'
require 'helpers/attendance'

RSpec.feature "User::Workflow::Exmas", type: :feature do

  before :each do
    Rails.application.load_seed
  end

  context "exam validations", js: true do

    before :each do
      create_attendance
      imunofeno_user_do_login
      click_link class: 'attendance-code', match: :first
      click_button id: 'exam_nav'
    end

    it "check how many exams are listed" do
      expect(find_all(class: 'exam').size).to eq @attendance.exams.size
    end

    context "exam verification" do

      before :each do
        @first_exam =  @attendance.exams
                                  .joins(:offered_exam)
                                  .where("offered_exams.field_id = ?", Field.IMUNOFENO.id)
                                  .order("offered_exams.name ASC").first
      end

      it "try start exam without internal code" do
        click_link class: 'start-exam', match: :first
        expect(page).to have_current_path start_exam_path(@first_exam)
        expect(find(id: 'exam-name').value).to eq @first_exam.offered_exam.name
        expect(page).to have_selector '#without-sample', visible: true
      end

      it "start exam" do
        click_button id: 'sample_nav'
        click_link class: 'new-internal-code', match: :first
        select(Field.find(@first_exam.offered_exam.field.id).name, from: 'internal_code[field_id]').select_option
        click_button id: 'btn-save'
        click_button id: 'exam_nav'
        click_link class: 'start-exam', match: :first
        click_button id: 'btn-save'
        expect(find(id: 'success-warning').text).to eq "Status de exame alterado para Em andamento."
      end

      # TODO: continuar da alteração de status entre os exames

    end

  end

end

require 'rails_helper'

RSpec.feature "User::Indicators::HealthEnsurancesRelations", type: :feature do
  include UserLogin

  def navigate_to
    click_link id: 'indicators'
    click_link id: 'health-ensurances-relation'
  end

  before :each do
    Rails.application.load_seed
    imunofeno_user_do_login
  end

  it "display with zero exams complete" do
    navigate_to
    expect(find(id: "total").text).to eq 0.to_s
  end

  it "display with one complete exam" do
    attendance = create(:attendance)
    exam = attendance.exams.sample
    exam.update(status: :complete)
    navigate_to
    expect(find(id: "total").text).to eq 1.to_s
  end

  it "display with distinct health ensurances" do
    first_attendance = create(:attendance, health_ensurance: HealthEnsurance.all.order(:name).first)
    second_attendance = create(:attendance, health_ensurance: HealthEnsurance.all.order(:name).last)
    first_attendance_exam = first_attendance.exams.sample
    first_attendance_exam.update(status: :complete)
    second_attendance_exam = second_attendance.exams.sample
    second_attendance_exam.update(status: :complete)
    navigate_to
    expect(find(id: "total").text).to eq 2.to_s
  end

  it "filter with no results" do
    first_attendance = create(:attendance, health_ensurance: HealthEnsurance.all.order(:name).first)
    first_attendance_exam = first_attendance.exams.sample
    first_attendance_exam.update(status: :complete, finish_date: 8.days.ago)
    navigate_to
    fill_in id: "start_date", with: 2.days.ago
    fill_in id: "end_date", with: 1.days.ago
    click_button id: 'btn-search'
    expect(find(id: "total").text).to eq 0.to_s
  end

end

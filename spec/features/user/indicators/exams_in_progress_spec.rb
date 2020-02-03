require 'rails_helper'

RSpec.feature "User::Indicators::ExamsInProgresses", type: :feature do
  include UserLogin

  def navigate_to
    click_link id: "indicators"
    click_link id: "exams-indicators-dropdown"
    click_link id: "exams-in-progress"
  end

  before :each do
    Rails.application.load_seed
    imunofeno_user_do_login
  end

  it "without exams" do
    navigate_to
    expect(find(id: "total").text).to eq 0.to_s
  end

  it "with one exam" do
    exam = Exam.create(offered_exam: create(:offered_exam), status: :progress)
    navigate_to
    expect(find(id: "total").text).to eq 1.to_s
  end

  it "with canceled" do
    exam = Exam.create(offered_exam: create(:offered_exam), status: :progress)
    exam = Exam.create(offered_exam: create(:offered_exam), status: :canceled)
    navigate_to
    expect(find(id: "total").text).to eq 1.to_s
  end

  it "with complete" do
    Exam.create(offered_exam: create(:offered_exam), status: :progress)
    Exam.create(offered_exam: create(:offered_exam), status: :in_repeat)
    Exam.create(offered_exam: create(:offered_exam), status: :complete)
    navigate_to
    expect(find(id: "total").text).to eq 2.to_s
  end

end

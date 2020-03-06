require 'rails_helper'
require 'json'

RSpec.describe FishApiController, type: :controller do
  include AttendanceHelper

  describe "users" do
    context "when there are no active users" do
      it "is expected to return an empty list" do
        get :users
        expect(response.body).to match "[]"
      end
    end
    context "when there are active users" do
      before :each do
        3.times { create(:user, kind: :user) }
      end
      it 'is expected to render all users' do
        get :users
        users = JSON.parse response.body
        expect(users.size).to eq 3
      end
    end
  end
  describe "exams" do
    before(:each) { Rails.application.load_seed }
    context "when there are no exams" do
      it 'is expected to return a empty list' do
        get :exams
        expect(response.body).to match "[]"
      end
    end
    context "when there are exams" do
      before :each do
        attendance = create_in_progress_fish_attendance
        attendance.exams << create(:exam, offered_exam: create(:offered_exam, field: Field.BIOMOL))
      end
      it 'is expected to return all open FISH exams' do
        get :exams
        exams = JSON.parse response.body
        expect(exams.size).to eq 1
      end
    end
  end
end

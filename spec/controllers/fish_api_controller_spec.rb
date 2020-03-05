require 'rails_helper'
require 'json'

RSpec.describe FishApiController, type: :controller do
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
end

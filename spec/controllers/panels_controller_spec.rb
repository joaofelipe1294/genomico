require 'rails_helper'

RSpec.describe PanelsController, type: :controller do

  describe "GET #exams" do
    it "returns http success" do
      get :exams
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #attendances" do
    it "returns http success" do
      get :attendances
      expect(response).to have_http_status(:success)
    end
  end

end

require 'rails_helper'

RSpec.describe "WorkMaps", type: :request do
  describe "GET /work_maps" do
    it "works! (now write some real specs)" do
      get work_maps_path
      expect(response).to have_http_status(200)
    end
  end
end

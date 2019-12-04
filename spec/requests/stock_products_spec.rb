require 'rails_helper'

RSpec.describe "StockProducts", type: :request do
  describe "GET /stock_products" do
    it "works! (now write some real specs)" do
      get stock_products_path
      expect(response).to have_http_status(200)
    end
  end
end

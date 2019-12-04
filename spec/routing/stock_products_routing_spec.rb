require "rails_helper"

RSpec.describe StockProductsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/stock_products").to route_to("stock_products#index")
    end

    it "routes to #new" do
      expect(:get => "/stock_products/new").to route_to("stock_products#new")
    end

    it "routes to #show" do
      expect(:get => "/stock_products/1").to route_to("stock_products#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/stock_products/1/edit").to route_to("stock_products#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/stock_products").to route_to("stock_products#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/stock_products/1").to route_to("stock_products#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/stock_products/1").to route_to("stock_products#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/stock_products/1").to route_to("stock_products#destroy", :id => "1")
    end
  end
end

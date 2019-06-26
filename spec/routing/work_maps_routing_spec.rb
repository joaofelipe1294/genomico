require "rails_helper"

RSpec.describe WorkMapsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/work_maps").to route_to("work_maps#index")
    end

    it "routes to #new" do
      expect(:get => "/work_maps/new").to route_to("work_maps#new")
    end

    it "routes to #show" do
      expect(:get => "/work_maps/1").to route_to("work_maps#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/work_maps/1/edit").to route_to("work_maps#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/work_maps").to route_to("work_maps#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/work_maps/1").to route_to("work_maps#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/work_maps/1").to route_to("work_maps#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/work_maps/1").to route_to("work_maps#destroy", :id => "1")
    end
  end
end

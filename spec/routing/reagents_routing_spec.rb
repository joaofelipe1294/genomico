require "rails_helper"

RSpec.describe ReagentsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/reagents").to route_to("reagents#index")
    end

    it "routes to #new" do
      expect(:get => "/reagents/new").to route_to("reagents#new")
    end

    it "routes to #show" do
      expect(:get => "/reagents/1").to route_to("reagents#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/reagents/1/edit").to route_to("reagents#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/reagents").to route_to("reagents#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/reagents/1").to route_to("reagents#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/reagents/1").to route_to("reagents#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/reagents/1").to route_to("reagents#destroy", :id => "1")
    end
  end
end

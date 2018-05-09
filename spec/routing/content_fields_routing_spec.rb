require "rails_helper"

RSpec.describe ContentFieldsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/content_fields").to route_to("content_fields#index")
    end

    it "routes to #new" do
      expect(:get => "/content_fields/new").to route_to("content_fields#new")
    end

    it "routes to #show" do
      expect(:get => "/content_fields/1").to route_to("content_fields#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/content_fields/1/edit").to route_to("content_fields#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/content_fields").to route_to("content_fields#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/content_fields/1").to route_to("content_fields#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/content_fields/1").to route_to("content_fields#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/content_fields/1").to route_to("content_fields#destroy", :id => "1")
    end

  end
end

require "rails_helper"

RSpec.describe BookResourcesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/book_resources").to route_to("book_resources#index")
    end

    it "routes to #new" do
      expect(:get => "/book_resources/new").to route_to("book_resources#new")
    end

    it "routes to #show" do
      expect(:get => "/book_resources/1").to route_to("book_resources#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/book_resources/1/edit").to route_to("book_resources#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/book_resources").to route_to("book_resources#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/book_resources/1").to route_to("book_resources#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/book_resources/1").to route_to("book_resources#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/book_resources/1").to route_to("book_resources#destroy", :id => "1")
    end

  end
end

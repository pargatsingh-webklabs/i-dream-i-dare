require "rails_helper"

RSpec.describe BioAnswersController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/bio_answers").to route_to("bio_answers#index")
    end

    it "routes to #new" do
      expect(:get => "/bio_answers/new").to route_to("bio_answers#new")
    end

    it "routes to #show" do
      expect(:get => "/bio_answers/1").to route_to("bio_answers#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/bio_answers/1/edit").to route_to("bio_answers#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/bio_answers").to route_to("bio_answers#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/bio_answers/1").to route_to("bio_answers#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/bio_answers/1").to route_to("bio_answers#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/bio_answers/1").to route_to("bio_answers#destroy", :id => "1")
    end

  end
end
